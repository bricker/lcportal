class AddAuthTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_token, :string
    User.all.each { |u| u.update_attribute(:auth_token, SecureRandom.urlsafe_base64) }
  end
end
