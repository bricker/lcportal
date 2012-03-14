class CreateWriters < ActiveRecord::Migration
  def change
    create_table :writers do |t|
      t.text :address
      t.timestamps
    end
  end
end
