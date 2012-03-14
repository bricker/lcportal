class DropWriters < ActiveRecord::Migration
  def up
    drop_table :writers
  end

  def down
    create_table :writers do |t|
      t.string :name
      t.string :email
      t.timestamps
    end
  end
end
