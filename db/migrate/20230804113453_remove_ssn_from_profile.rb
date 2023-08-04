class RemoveSsnFromProfile < ActiveRecord::Migration[7.0]
  def change
    remove_column :profiles, :ssn
  end
end
