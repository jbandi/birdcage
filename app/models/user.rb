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
end