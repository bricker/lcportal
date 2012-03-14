class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.integer :writer_id
      t.has_attached_file :asset
      t.timestamps
    end
  end
end
