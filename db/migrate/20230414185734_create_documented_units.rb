class CreateDocumentedUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :documented_units, id: :uuid do |t|
      t.references :code, null: false, foreign_key: true, type: :uuid
      t.references :visit, null: false, foreign_key: true, type: :uuid
      t.integer :unit_count

      t.timestamps
    end
  end
end
