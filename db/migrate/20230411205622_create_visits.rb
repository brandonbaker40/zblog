class CreateVisits < ActiveRecord::Migration[7.0]
  def change
    create_table :visits, id: :uuid do |t|
      t.date :date_of_service
      t.references :patient, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
