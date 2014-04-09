# friendships_controller.rb
class FriendshipsController < ApplicationController

  before_action :require_authentication

  def all
    if current_user.admin
      @friendships = Friendship.all
      render 'all'
    else
      redirect_to root_path
    end
  end

  def index
    # Index of current user's friends
    @friendships = current_user.friendships
  end

  def new
    @friendship = Friendship.new
    @other_users = current_user.other_users
    if @other_users.empty?
      flash[:notice] = "Cannot add more friends since you are already friends with all users!"
      redirect_to :back
    end
  end

  def create
    @friendship = Friendship.create(friendship_params)
    @friendship.update(:user_id => params[:user_id])
    redirect_to user_friendships_path(current_user)
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if current_user.id == @friendship.user_id || current_user.admin 
      @friendship.destroy
      redirect_to user_friendships_path(current_user)
    else
      redirect_to :back
    end
  end

  private
    def friendship_params
      params.require(:friendship).permit(:friend_id)
    end

end