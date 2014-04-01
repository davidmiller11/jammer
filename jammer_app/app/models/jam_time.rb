# jam_time.rb
class JamTime < ActiveRecord::Base
  belongs_to :jam
  has_many :rsvps, dependent: :destroy
end