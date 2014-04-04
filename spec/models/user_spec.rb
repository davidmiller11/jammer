require 'spec_helper'

describe User do
  it 'is invalid without an email' do
    user = User.new
    # be_invalid is called a predicate matcher
    expect(user).to be_invalid
  end

  it 'has jams' do
    user = User.create(email: 'ghost@ghost.com', password: 1, password_confirmation: 1)
    jam = Jam.create(user_id: user.id)
    expect(user.jams).to include(jam)
  end

  describe '#full_name' do
    it 'has a full name' do
      user = User.create(first_name: 'Tommy', last_name: 'Bahama', email: 'ghost@ghost.com', password: 1, password_confirmation: 1)
      expect(user.full_name).to eq('Tommy Bahama')
    end
  end

  context 'after user has been invited to at least 1 jam' do
    describe '#jams_invited_to' do
      it 'returns an array of jams the user has been invited to' do
        user = User.create(first_name: 'Tommy', last_name: 'Bahama', email: 'ghost@ghost.com', password: 1, password_confirmation: 1)
        jam = Jam.create
        jam_time = JamTime.create(jam_id: jam.id)
        rsvp = Rsvp.create(jam_time_id: jam_time.id, user_id: user.id)
        expect(user.jams_invited_to).to include(jam)
      end
    end
  end
end