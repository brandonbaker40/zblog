class CreateWorkers < ActiveRecord::Migration[7.0]
  def change
    create_table :workers, id: :uuid do |t|
      t.integer :worker_type
      t.string :payroll_workerId
      t.string :work_email
      t.string :personal_email
      t.string :contact_phone
      t.date :date_of_birth
      t.references :profile, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
