# rsvp.rb
class Rsvp < ActiveRecord::Base
  belongs_to :jam_time

  # %w converts string to array
  validates :answer, inclusion: { in: %w(yes no ifnec), message: "%{value} is not a valid rsvp"}


  def self.create_many(j_times, guest_ids)
    @j_times = j_times
    @guest_ids = guest_ids

    @j_times.each do |jam_time|
      @guest_ids.each do |guest_id|
        Rsvp.create({
          :jam_time_id => jam_time.id,
          :user_id => guest_id
          })
      end
    end
    binding.pry
  end

end