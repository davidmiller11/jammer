# jam_spec.rb
require 'spec_helper'

describe Jam do
  
  # it { should belong_to(:user) }
  it { should have_many(:jam_times).dependent(:destroy) }
  it { should have_many(:rsvps).through(:jam_times) }

  describe '#invitee_ids' do
    pending
  end

  context 'For a jam that has been created' do
    describe '#creator' do
      let(:user) {User.create(:email => 'david@example.edu', :password => '1', :password_confirmation => '1')}
      subject(:j) {Jam.create(:name => 'Coffee', :user_id => user.id)}
      it 'returns the user object who created the jam' do
        expect(j.creator).to eq(user)
      end
    end

    describe '#user_count' do
      it 'should return the number of users invited to the jam, including the creator' do
        user1 = User.create(first_name: 'Tommy', last_name: 'Bahama', email: 'user1@test.com', password: 1, password_confirmation: 1)
        user2 = User.create(first_name: 'Tommy', last_name: 'Bahama', email: 'user2@test.com', password: 2, password_confirmation: 2)
        user3 = User.create(first_name: 'Tommy', last_name: 'Bahama', email: 'user3@test.com', password: 3, password_confirmation: 3)
        jam1 = Jam.create
        jam_time1 = JamTime.create(jam_id: jam1.id, start_date: "2014-05-05", start_time: "3:00pm")
        rsvp1 = Rsvp.create(jam_time_id: jam_time1.id, user_id: user1.id)
        rsvp2 = Rsvp.create(jam_time_id: jam_time1.id, user_id: user2.id)
        rsvp3 = Rsvp.create(jam_time_id: jam_time1.id, user_id: user3.id)
        expect(jam1.user_count).to eq(3)
      end
    end
  end

end