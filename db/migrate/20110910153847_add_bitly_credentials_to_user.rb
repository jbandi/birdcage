class AddBitlyCredentialsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :bitly_login, :string
    add_column :users, :bitly_password, :string
  end

  def self.down
    remove_column :users, :bitly_login
    remove_column :users, :bitly_password
  end
end
