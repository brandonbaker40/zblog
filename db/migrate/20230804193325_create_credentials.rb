class CreateCredentials < ActiveRecord::Migration[7.0]
  def change
    create_table :credentials, id: :uuid do |t|
      t.references :requirement, null: false, foreign_key: true, type: :uuid
      t.references :profile, null: false, foreign_key: true, type: :uuid
      t.date :expiration_date

      t.timestamps
    end
  end
end
