# rsvp.rb
class Rsvp < ActiveRecord::Base
  belongs_to :jam_time
  belongs_to :user

  validates :answer, inclusion: { in: ["yes", "no", "ifnec", nil], message: "%{value} is not a valid answer"}

  def self.create_many(jam_times, invitee_ids)
    jam_times.each do |jam_time|
      invitee_ids.each do |invitee_id|
        Rsvp.create({
          :jam_time_id => jam_time.id,
          :user_id => invitee_id
          })
      end
    end
  end

end