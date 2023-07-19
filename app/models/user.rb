class User < ApplicationRecord
  after_create do |user|
    Profile.find_or_create_by(user: user)
  end

  validates :email, presence: true

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

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
