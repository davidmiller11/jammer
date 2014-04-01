# jam.rb
class Jam < ActiveRecord::Base
  # has_many just adds helper methods
  belongs_to :user
  has_many :jam_times, dependent: :destroy

  # returns the user_id's of a jam's invited users in an array
  def guest_ids
    guest_id_ary = self.jam_times.first.rsvps.map { |rsvp| rsvp.user_id }

    return guest_id_ary
  end

end