class AddProviderOrganizationToVisits < ActiveRecord::Migration[7.0]
  def change
    add_reference :visits, :provider_organization, null: false, foreign_key: true, type: :uuid
  end
end
