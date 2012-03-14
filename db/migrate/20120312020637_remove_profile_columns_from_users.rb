class RemoveProfileColumnsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :profile_type
    remove_column :users, :profile_id
  end

  def down
    add_column :users, :profile_type, :string
    add_column :users, :profile_id, :integer
  end
end
