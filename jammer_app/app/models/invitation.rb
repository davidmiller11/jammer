# invitation.rb
class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :date

  # validates :rsvp, includsion: { in: %w(yes no ifnec), message: "%{value} is not a valid rsvp"}
end