class AddPostTrackingToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :post_interval, :integer, :default => 60
    add_column :users, :last_post, :datetime
  end

  def self.down
    remove_column :users, :post_interval
    remove_column :users, :last_post
  end
end
