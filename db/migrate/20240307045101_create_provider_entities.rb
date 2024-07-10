class CreateProviderEntities < ActiveRecord::Migration[7.0]
  def change
    create_table :provider_entities, id: :uuid do |t|
      t.references :profile, null: false, foreign_key: true, type: :uuid
      t.references :provider_organization, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
