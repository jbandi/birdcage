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

  def last_post_timestamp
    last_post.to_s(:short)
  end

  def next_post
    if last_post + post_interval.minutes - Time.now > 0
     last_post + post_interval.minutes
   else
      Time.now
    end
  end

end