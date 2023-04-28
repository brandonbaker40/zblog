class AddNameToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :name, :string
  end
end
