class CreatePatientEntities < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_entities, id: :uuid do |t|
      t.references :patient, null: false, foreign_key: true, type: :uuid
      t.references :provider_organization, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
