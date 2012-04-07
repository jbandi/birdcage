class HomeController < ApplicationController
  skip_before_filter :authenticate

  def index
    respond_to do |format|
      format.html do
        @tweet = Tweet.new
        @tweets = current_user.tweets.where("sent = ?", false).order("priority desc, created_at asc") unless !current_user
      end
      format.js do
        @bitly_login = current_user.bitly_login
        @bitly_api_key = current_user.bitly_password
      end
    end
  end

end