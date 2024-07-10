class ProviderEntity < ApplicationRecord
  belongs_to :profile
  belongs_to :provider_organization
end
