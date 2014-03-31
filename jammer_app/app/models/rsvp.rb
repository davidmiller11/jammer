# rsvp.rb
class Rsvp < ActiveRecord::Base
  belongs_to :jam_time

  # %w converts string to array
  validates :answer, inclusion: { in: %w(yes no ifnec), message: "%{value} is not a valid rsvp"}
end