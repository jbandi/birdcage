class AddPriorityToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :priority, :decimal, :default => 0
  end

  def self.down
    remove_column :tweets, :priority
  end
end
