require 'spec_helper'

describe User do
  let (:user) { FactoryGirl.create(:user) }
  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:provider) }
  it { should respond_to(:uid) }
  it { should respond_to(:token) }
  it { should respond_to(:avatar_url) }

  it { should be_valid }

  context 'when provider is not present' do
    before { user.provider = nil }
    it { should_not be_valid }
  end
  context 'when uid is not present' do
    before { user.uid = nil }
    it { should_not be_valid }
  end
  context 'when token is not present' do
    before { user.token = nil }
    it { should_not be_valid }
  end

  describe '.create_with_omniauth' do
    let (:auth_hash) { auth_hash = { provider: 'facebook',
                                     uid: '1234567',
                                     info: { email:'joe@bloggs.com',
                                             name: 'Joe Bloggs',
                                             image: 'http://graph.facebook.com/1234567/picture?type=square' },
                                     credentials: { :token => 'ABCDEF...' } } }

    context 'with valid auth hash' do
      it 'returns a valid user' do
        user = User.create_with_omniauth(auth_hash)
        expect(user).to be_valid
      end
    end

    context 'with invalid auth hash' do
      it 'returns an invalid user' do
        auth_hash[:provider] = nil
        expect(User.create_with_omniauth(auth_hash)).not_to be_valid
      end
    end
  end

end
