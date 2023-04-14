class CreateCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :codes, id: :uuid do |t|
      t.string :label

      t.timestamps
    end
  end
end
