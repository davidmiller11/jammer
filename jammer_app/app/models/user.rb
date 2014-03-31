# user.rb
class User < ActiveRecord::Base
  has_secure_password

  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :jams

  def full_name
    return self.first_name + " " + self.last_name
  end
end