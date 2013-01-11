class AddAssetTokenToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :asset_token, :string

  end
end
