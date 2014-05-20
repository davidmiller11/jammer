require 'spec_helper'

describe JamTime do
  it { should belong_to(:jam) }
  it { should have_many(:rsvps).dependent(:destroy) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:start_time) }
end