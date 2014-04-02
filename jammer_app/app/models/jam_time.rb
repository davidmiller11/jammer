# jam_time.rb
class JamTime < ActiveRecord::Base
  belongs_to :jam
  has_many :rsvps, dependent: :destroy

  def start_date_formatted
    return self.start_date.strftime("%A, %B %e, %Y")
  end

  def start_time_formatted
    return self.start_time.strftime("%l:%M %P")
  end
end