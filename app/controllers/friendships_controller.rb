# friendships_controller.rb
class FriendshipsController < ApplicationController

  before_action :require_authentication

  def all
    @f_ships = Friendship.all
    current_user.admin ? render 'all' : redirect_to root_path
  end

  def index
    # Index of current user's friends
    @f_ships = current_user.friendships
  end

  def new
    @friendship = Friendship.new
    @other_users = current_user.other_users
  end

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.save
    redirect_to user_friendships_path(current_user)
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if current_user.admin || current_user.id == @friendship.user_id  
      @friendship.destroy
      redirect_to user_friendships_path(current_user)
    else
      redirect_to :back
    end
  end

  private
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id)
    end

end