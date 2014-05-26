require 'spec_helper'

describe User do

  it { should have_secure_password }
  it { should validate_presence_of(:email) }
  it do
    User.create!(email: 'david@david.com', password: 1, password_confirmation: 1)
    should validate_uniqueness_of(:email)
  end  
  it { should have_many(:friendships).dependent(:destroy) }
  it { should have_many(:friends).through(:friendships) }
  # it { should have_many(:jams).dependent(:destroy) }
  it { should have_many(:rsvps) }

  it 'is invalid without an email' do
    user = User.new
    # be_invalid is called a predicate matcher
    expect(user).to be_invalid
  end

  describe '#full_name' do
    it 'has a full name' do
      user = User.create(first_name: 'Tommy', last_name: 'Bahama', email: 'ghost@ghost.com', password: 1, password_confirmation: 1)
      expect(user.full_name).to eq('Tommy Bahama')
    end
  end

  describe '#other_users' do
    it 'returns array of all other users' do
      user1 = User.create(first_name: 'John1', last_name: 'Doe1', email: 'user1@test.com', password: 1, password_confirmation: 1)
      user2 = User.create(first_name: 'John2', last_name: 'Doe2', email: 'user2@test.com', password: 2, password_confirmation: 2)
      expect(user1.other_users).to include(user2)
      expect(user1.other_users).to_not include(user1)
    end
  end

  context 'After user has been invited to at least 1 jam' do
    describe '#jams_invited_to' do
      it 'returns an array of jams the user has been invited to' do
        user1 = User.create(first_name: 'Tommy', last_name: 'Bahama', email: 'ghost@ghost.com', password: 1, password_confirmation: 1)
        jam1 = Jam.create
        jam_time1 = JamTime.create(jam_id: jam1.id, start_date: "2014-05-05", start_time: "3:00pm")
        rsvp1 = Rsvp.create(jam_time_id: jam_time1.id, user_id: user1.id)
        expect(user1.jams_invited_to).to include(jam1)
      end
    end
  end

  context 'After user has been invited to at least 1 jam and created his/her own jam' do
    describe '#jams' do
      it 'returns an array of jams created or invited to' do
        user1 = User.create(first_name: 'John1', last_name: 'Doe1', email: 'user1@test.com', password: 1, password_confirmation: 1)
        user2 = User.create(first_name: 'John2', last_name: 'Doe2', email: 'user2@test.com', password: 2, password_confirmation: 2)
        jam1 = Jam.create(user_id: user1.id)
        jam2 = Jam.create(user_id: user2.id)
        jam_time1 = JamTime.create(jam_id: jam1.id, start_date: "2014-05-05", start_time: "3:00pm")
        jam_time2 = JamTime.create(jam_id: jam2.id, start_date: "2014-05-05", start_time: "3:00pm")
        rsvp1 = Rsvp.create(jam_time_id: jam_time1.id, user_id: user1.id)
        rsvp2 = Rsvp.create(jam_time_id: jam_time2.id, user_id: user2.id)
        rsvp3 = Rsvp.create(jam_time_id: jam_time2.id, user_id: user1.id)
        expect(user1.jams_invited_to).to include(jam1)
        expect(user1.jams_invited_to).to include(jam2)
      end
    end
  end
end