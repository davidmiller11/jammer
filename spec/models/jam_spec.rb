# jam_spec.rb
require 'spec_helper'

describe Jam do
  
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
  end

end