require 'spec_helper'

describe Friendship do
  it { should belong_to(:user) }
  it { should belong_to(:friend).class_name('User') }
  it { should validate_uniqueness_of(:friend_id).scoped_to(:user_id) }
end