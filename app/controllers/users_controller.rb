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
    @user = User.new(user_params)
    if @user.save
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
    else
      User.transaction do
        
        # Before deleting user, delete friendships where user is the friend
        Friendship.where(friend_id: @user.id).delete_all

        @user.destroy
      end
      
      redirect_to users_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

end