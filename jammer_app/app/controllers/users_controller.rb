# users_controller.rb
class UsersController < ApplicationController

  before_action :require_authentication, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])

    if current_user == @user || current_user.admin == true
      render 'edit'
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user == @user || current_user.admin == true
      @user.update(user_params)
      @user.save
      redirect_to users_path
    else
      redirect_to root_path
    end
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
    end

end