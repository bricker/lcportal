class DropWritersTable < ActiveRecord::Migration
  def up
    drop_table :writers
  end

  def down
    create_table :writers do |t|
      t.text :address
      t.string :phone_number
      t.timestamps
    end
  end
end
