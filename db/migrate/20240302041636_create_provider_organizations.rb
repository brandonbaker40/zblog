class CreateProviderOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :provider_organizations, id: :uuid do |t|
      t.string :name
      t.integer :kind

      t.timestamps
    end
  end
end
