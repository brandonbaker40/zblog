class RemoveUserFromProfile < ActiveRecord::Migration[7.0]
  def change
    remove_reference :profiles, :user, if_exists: true
  end
end
