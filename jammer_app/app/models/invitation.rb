# invitation.rb
class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :date

  # %w converts string to array
  validates :rsvp, inclusion: { in: %w(yes no ifnec), message: "%{value} is not a valid rsvp"}
end