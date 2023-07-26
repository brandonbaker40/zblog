class Profile < ApplicationRecord
  encrypts :ssn

  has_one :user_profile

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  enum role: [:providerguy, :admin, :dual]

  validates_uniqueness_of :email

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :ssn, presence: true

  validates_format_of :ssn, with: /\A((?!219-09-9999|078-05-1120)(?!666|000|9\d{2})\d{3}-(?!00)\d{2}-(?!0{4})\d{4})|((?!219 09 9999|078 05 1120)(?!666|000|9\d{2})\d{3} (?!00)\d{2} (?!0{4})\d{4})|((?!219099999|078051120)(?!666|000|9\d{2})\d{3}(?!00)\d{2}(?!0{4})\d{4})\z/



end
