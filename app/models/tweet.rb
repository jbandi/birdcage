class Tweet < ActiveRecord::Base
  belongs_to :user
  
  MIN_PRIORITY_INCREMENT = 0.00000001

  def increase_priority

    tweets_above = Tweet.where("user_id = ? and sent = ? and priority > ?", user_id, false, priority).order("priority").limit(2).all
    if (tweets_above.length == 2)
      increment = (tweets_above[1].priority - tweets_above[0].priority) / 2
      increment = increment == 0 ? MIN_PRIORITY_INCREMENT : increment
      self[:priority] = tweets_above[0].priority + increment
    elsif (tweets_above.length == 1)
      self[:priority]=tweets_above[0].priority + MIN_PRIORITY_INCREMENT
    else
      self[:priority] += MIN_PRIORITY_INCREMENT
    end

    save!

  end
  
  def set_top_priority
    max_prio = Tweet.where("user_id=?", user_id).maximum("priority")
    self[:priority] = max_prio + MIN_PRIORITY_INCREMENT
    
    save!
  end

end