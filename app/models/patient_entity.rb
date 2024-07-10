class PatientEntity < ApplicationRecord
  belongs_to :patient
  belongs_to :provider_organization
end
