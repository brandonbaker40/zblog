class Profile < ApplicationRecord

  has_one :user_profile

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  enum role: [:provider, :admin, :dual]

  validates_uniqueness_of :email

  validates :first_name, presence: true
  validates :last_name, presence: true
end
