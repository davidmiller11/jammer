# users_controller.rb
class UsersController < ApplicationController

  before_action :require_authentication, only: [:index, :show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    if @user = User.create(user_params)
      # success
      UserMailer.welcome_email(@user).deliver
      redirect_to @user
    else
      # error handling
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])

    if @user == current_user || current_user.admin
      render 'edit'
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user || current_user.admin
      @user.update(user_params)
      @user.save
      redirect_to users_path
    else
      redirect_to root_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    if !current_user.admin
      redirect_to :back
    end

    @user.destroy
    redirect_to users_path

  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
    end

end