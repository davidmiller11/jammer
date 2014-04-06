# jam.rb
class Jam < ActiveRecord::Base
  # has_many just adds helper methods
  belongs_to :user
  has_many :jam_times, dependent: :destroy

  def created_at_formatted
    return self.created_at.strftime("%A, %B %e, %Y at %l:%M %P")
  end

  # returns the user_id's of a jam's invited users in an array
  def guest_ids
    guest_id_ary = self.jam_times.first.rsvps.map { |rsvp| rsvp.user_id }
    return guest_id_ary
  end

  # returns ary of user objects invited to a jam
  def invitees
    invitees = self.jam_times.first.rsvps.map{|rsvp| User.find(rsvp.user_id)}
    return invitees
  end

  def creator
    return User.find(self.user_id)
  end
end