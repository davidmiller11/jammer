# user.rb
class User < ActiveRecord::Base
  has_secure_password

  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :jams, dependent: :destroy

  def full_name
    return self.first_name + " " + self.last_name
  end

  # returns all the jams in an array that a user has been invited to
  def jams_invited_to
    # get array of all rsvps for user
    @rsvps = Rsvp.where(user_id: self.id)

    # get array of all jam_times for user
    @jam_times = @rsvps.map do |rsvp|
      JamTime.find(rsvp.jam_time_id)
    end

    # get array of all jams user was invited to
    @jams = @jam_times.map do |jam_time|
      Jam.find(jam_time.jam_id)
    end

    # return array of all jams with duplicates removed.
    return @jams.uniq
  end
end