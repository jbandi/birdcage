class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.text :content
      t.boolean :sent, :default => false
      t.integer :user_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
