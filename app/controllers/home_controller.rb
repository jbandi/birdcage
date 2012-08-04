class HomeController < ApplicationController
  skip_before_filter :authenticate

  def index
    respond_to do |format|
      format.html do
        if (current_user)
          @tweet = Tweet.new
          @tweets = current_user.unsent_tweets unless !current_user
          @latest_tweet_content = current_user.latest_tweet_content unless !current_user
        end
      end
      format.js do
        @bitly_login = current_user.bitly_login
        @bitly_api_key = current_user.bitly_password
      end
    end
  end

end