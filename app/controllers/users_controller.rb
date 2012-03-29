class UsersController < ApplicationController

  def activate
    puts "hello activate2 /" + params.to_yaml + "/"

    current_user.active=params[:user][:active]
    current_user.save

    redirect_to(:back )
    
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(:bitly_login => params[:user][:bitly_login], 
                                  :bitly_password => params[:user][:bitly_password],
                                  :post_interval => params[:user][:post_interval])
        format.html { redirect_to(root_url, :notice => 'User was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

end