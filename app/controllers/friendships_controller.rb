# friendships_controller.rb
class FriendshipsController < ApplicationController

  def all
    if current_user.admin == true
      @friendships = Friendship.all
      render 'all'
    else
      redirect_to root_path
    end
  end

  def index
    @friendships = current_user.friendships
  end

  def new
    @friendship = Friendship.new
    @other_users = User.all
    @other_users.delete_at(@other_users.index(current_user))
  end

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.save
    redirect_to user_friendships_path(current_user)
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to user_friendships_path(current_user)
  end

  private
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id)
    end

end