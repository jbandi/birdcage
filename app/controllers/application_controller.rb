class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate
  helper_method :current_user
  
  private

      def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      end

      def authenticate
        unless current_user && (["test_jb", "test_jb2", "jbandi"].include?(current_user.name))
          msg = "Must be logged in!"
          if current_user
            msg = "Only restricted users are allowed access!"
          end
          redirect_to root_path, :notice => msg

        end
      end
end
