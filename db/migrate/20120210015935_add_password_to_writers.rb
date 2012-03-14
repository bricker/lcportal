class AddPasswordToWriters < ActiveRecord::Migration
  def change
    add_column :writers, :password_digest, :string
  end
end
