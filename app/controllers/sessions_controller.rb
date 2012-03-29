class SessionsController < ApplicationController
  skip_before_filter :authenticate

  def create

#    raise request.env["omniauth.auth"].to_yaml

    auth = request.env["omniauth.auth"]
    logger.info auth["info"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id

    redirect_to root_url, :notice => "Signed in!"

  end

  def failure
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_url, :notice => "Signed out!"
  end
end