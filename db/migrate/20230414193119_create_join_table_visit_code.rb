class CreateJoinTableVisitCode < ActiveRecord::Migration[7.0]
  def change
    create_join_table :codes, :visits do |t|
      # t.index [:code_id, :visit_id]
      # t.index [:visit_id, :code_id]
    end
  end
end
