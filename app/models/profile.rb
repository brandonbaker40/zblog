class Profile < ApplicationRecord
  after_create :import_payroll_data_from_paychex

  has_one :user_profile, dependent: :destroy

  has_one :worker, dependent: :destroy
  accepts_nested_attributes_for :worker

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  enum role: [:provider, :admin, :dual]

  validates_uniqueness_of :email # only one profile per Azure AD UPN
  # UPN's on Azure AD tenant with different domains (external users) are not permitted to use this application
  validates_format_of :email, with: /\A[A-Za-z0-9._%+-]+@bakerrehabgroup\.com\z/ 

  validates :first_name, presence: true
  validates :last_name, presence: true

  # validates :ssn, presence: true
  # validates_format_of :ssn, with: /\A((?!219-09-9999|078-05-1120)(?!666|000|9\d{2})\d{3}-(?!00)\d{2}-(?!0{4})\d{4})|((?!219 09 9999|078 05 1120)(?!666|000|9\d{2})\d{3} (?!00)\d{2} (?!0{4})\d{4})|((?!219099999|078051120)(?!666|000|9\d{2})\d{3}(?!00)\d{2}(?!0{4})\d{4})\z/
  # encrypts :ssn

private

def import_payroll_data_from_paychex
  # Authenticate on Paychex API
  token = PaychexApiService::Authenticate.new.call
  PaychexApiService::BuildWorkerProfile.new(self, token).call
end

end
