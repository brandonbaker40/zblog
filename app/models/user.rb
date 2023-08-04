class User < ApplicationRecord
  after_create do |user|

    token = MicrosoftGraphService::Authenticate.new.call
    aad_object = MicrosoftGraphService::FetchUser.new(user, token).call

    if Profile.where(email: aad_object["mail"]).exists?
      prof = Profile.find_by(email: aad_object["mail"]) # validation on email uniqueness makes sure there is only 1 record to return
      prof.update_columns(first_name: aad_object["givenName"], last_name: aad_object["surname"]) # overwrites the value in profile
    else
      # if aad user email does not have a profile yet, a profile will be created for them
      # an admin will need to assign fields
      prof = Profile.create(email: aad_object["mail"], first_name: aad_object["givenName"], last_name: aad_object["surname"])
    end

    UserProfile.create(user: user, profile: prof)
  end

  validates :email, presence: true

  has_one :user_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers:
         %i[azure_activedirectory_v2]

  def self.from_omniauth(auth)
    # find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
    # In future iterations, we may pass more than one parameter from AzureAD, i.e. first_name, last_name
    find_or_create_by(email: auth.email) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
      # Profile.find_or_create_by(user: user)
    end
  end
end
