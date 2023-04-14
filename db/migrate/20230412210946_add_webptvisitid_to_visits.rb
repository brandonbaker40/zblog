class AddWebptvisitidToVisits < ActiveRecord::Migration[7.0]
  def change
    add_column :visits, :webptvisitid, :string
  end
end
