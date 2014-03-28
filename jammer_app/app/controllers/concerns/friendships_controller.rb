# friendships_controller.rb
class FriendshipsController < ApplicationController

  def index
    @friendships = current_user.friends
  end

  def new
    @friendship = Friendship.new
    @other_users = User.all

    @other_users.delete_at(@other_users.index(current_user))

  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end