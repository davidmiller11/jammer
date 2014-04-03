# friendship.rb
class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  # to prevent duplicate rows in the table for user_id and friend_id
  validates_uniqueness_of :friend_id, :scope => [:user_id]
end