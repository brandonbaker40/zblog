class ProviderOrganization < ApplicationRecord
    enum kind: [:home_health_agency, :surgery_center] # Alias "Type" cannot be used since it is a reserved keyword for database field names

    has_many :patient_provider_organizations

    has_one :address, as: :addressable, dependent: :destroy
    accepts_nested_attributes_for :address
end
