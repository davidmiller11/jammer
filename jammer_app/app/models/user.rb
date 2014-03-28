# user.rb
class User < ActiveRecord::Base
  has_secure_password

  has_many :friendships
  has_many :friends, :through => :friendships
end