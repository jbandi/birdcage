class User < ActiveRecord::Base
  has_many :tweets

  def self.create_with_omniauth(auth)
    create! do |user|
      user.name = auth["info"]["name"]
      user.uid = auth["uid"]
      user.provider = auth["provider"]
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
    end
  end

  def latest_tweet_time
    if last_post 
      last_post.to_s(:short) 
    else
      ""
    end
  end

  def next_tweet_time
    if last_post && last_post + post_interval.minutes - Time.now > 0
     last_post + post_interval.minutes
    else
      Time.now
    end
  end

  def unsent_tweets
    tweets.where("sent = ?", false).order("priority desc, created_at asc")
  end

  def latest_tweet_content
    t = tweets.where("sent = ?", true).order("updated_at desc").first
    if t
      t.content
    else
      ""
    end
  end

end