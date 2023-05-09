class AddReportToImport < ActiveRecord::Migration[7.0]
  def change
    add_column :imports, :report, :integer
  end
end
