# location.rb
class Location < ActiveRecord::Base
  belongs_to :event
end