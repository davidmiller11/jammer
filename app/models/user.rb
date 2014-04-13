# user.rb
class User < ActiveRecord::Base
  # has_secure_password automatically adds validation of presence of password and confirmation on create
  has_secure_password

  validates :email, uniqueness: true, presence: true

  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships

  has_many :jams, dependent: :destroy
  has_many :rsvps

  def full_name
    f = self.first_name
    l = self.last_name
    if f && l
      return f + " " + l
    elsif f
      return f
    elsif l
      return l
    else
      return ""
    end
  end

  def user_name
    return self.email.split("@").first
  end

  def index_view_header
    return self.admin ? "Admin: Viewing all Jams" : "I made these Jams"
  end

  def other_users
    return User.all.select { |user| !user.admin && user != self && !self.friends.include?(user) }
  end

  # returns an array of all jams a user has been invited to
  def jams_invited_to
    return Rsvp.where(user_id: self.id).map {|rsvp| rsvp.jam_time.jam }.uniq
  end
end