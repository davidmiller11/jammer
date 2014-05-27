# jam.rb
class Jam < ActiveRecord::Base
  # has_many just adds helper methods
  # belongs_to :user
  has_many :jam_times, dependent: :destroy
  has_many :rsvps, through: :jam_times

  def created_at_formatted
    return self.created_at.strftime("%A, %B %e, %Y at %l:%M %P")
  end

  # returns the user_id's of a jam's invited users in an array
  def invitee_ids
    return self.jam_times.first.rsvps.map { |rsvp| rsvp.user_id }
  end

  # returns ary of user objects invited to a jam
  def invitees
    # invitees = self.jam_times.first.rsvps.map{|rsvp| User.find(rsvp.user_id)}
    invitees = User.find( self.invitee_ids )
    return invitees
  end

  def user_count 
    return self.jam_times.first.rsvps.count
  end

  def creator
    # return self.user
    return User.find(self.user_id)
  end

  def final_status
    return self.finalized ? "Confirmed" : "Pending"
  end

  
end