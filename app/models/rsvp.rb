# rsvp.rb
class Rsvp < ActiveRecord::Base
  belongs_to :jam_time

  validates :answer, inclusion: { in: ["yes", "no", "ifnec", nil], message: "%{value} is not a valid answer"}

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
    # binding.pry
  end

end