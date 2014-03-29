# date.rb
class Date < ActiveRecord::Base
  has_many :invitations
end