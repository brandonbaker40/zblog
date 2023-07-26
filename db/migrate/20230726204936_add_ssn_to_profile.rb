class AddSsnToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :ssn, :string
  end
end
