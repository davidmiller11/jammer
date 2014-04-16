# logins_controller.rb
class LoginsController < ApplicationController
# 'Create' a login, aka 'log the user in'
  def new
    redirect_to root_path if current_user
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:current_user_id] = @user.id
      redirect_to jams_path
    else
      render 'new'
    end
  end

  def destroy
    session[:current_user_id] = nil
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
  end

end