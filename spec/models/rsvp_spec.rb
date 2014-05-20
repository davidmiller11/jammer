require 'spec_helper'

describe Rsvp do
  it { should belong_to(:jam_time) }
  it { should belong_to(:user) }
  it { should ensure_inclusion_of(:answer).in_array(["yes", "no", "ifnec", nil]) }
end