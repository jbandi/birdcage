require 'rubygems'
require 'clockwork'
require_relative '../config/boot'
require_relative '../config/environment'

include Clockwork


every(1.minute, 'Tweet Sender') {
  
  log "Starting scheduling round..."
  
  activeUsers = User.where("approved = ? and active = ?", true, true)
  
  log "Active user count: " + activeUsers.count.to_s

  activeUsers.each do |user|
    
    user.reload()
    
    if user.last_post != nil && user.last_post + user.post_interval.minutes > Time.now 
      min_unitl_next_tweet = (user.last_post.advance(:minutes => user.post_interval) - Time.now)/60
      log user.name + ": Its not yet time for the next tweet. Waiting another " + min_unitl_next_tweet.to_s + " minutes."
      
    else  
    
      log user.name + ": scheduling next tweet."
    
      next_tweet = user.tweets.where("sent = ?", false).order("priority desc, created_at asc").first
    
      if next_tweet
        Twitter.configure do |config|
          # consumer key/secret are configured in config/initializers/twitter.rb
          config.oauth_token = user.token
          config.oauth_token_secret = user.secret
        end
      
        client = Twitter::Client.new
        client.update next_tweet.content

        log user.name + ": sent a tweet -> " + next_tweet.content[0..30] + "..." 

        next_tweet.sent = true;
        next_tweet.save
        user.last_post = Time.now
        user.save
      else
        log user.name + ": no tweets available."
      end
      
      log user.name + ": finished tweet scheduling."
    end
    
  end  
}