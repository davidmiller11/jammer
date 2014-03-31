# event.rb
class Event < ActiveRecord::Base
  # has_many just adds helper methods
  has_many :invitations
  has_many :users, :through => :invitations
end