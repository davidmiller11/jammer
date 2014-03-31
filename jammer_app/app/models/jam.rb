# jam.rb
class Jam < ActiveRecord::Base
  # has_many just adds helper methods
  belongs_to :user
  has_many :jam_times
end