require 'spec_helper'

describe SessionsController do

  describe 'GET #create' do
    let (:user) { FactoryGirl.create(:user) }
    let (:omniauth_hash) do
      { 'omniauth.auth' => { provider: user.provider,
                             uid: user.uid,
                             info: { email: user.email,
                                     name: user.name,
                                     image: user.avatar_url },
                             credentials: { :token => user.token }
                            } }
    end

    context 'when a user is revisiting' do
      it 'does not create another user' do
        request.stub(:env).and_return(omniauth_hash)    
        expect{ get :create, provider: user.provider }.not_to change(User, :count)
      end
    end
    
    context 'when a user is new' do
      it 'creates a new user' do
        omniauth_hash['omniauth.auth'][:uid] << '1'
        request.stub(:env).and_return(omniauth_hash)    
        expect{ get :create, provider: user.provider }.to change(User, :count).by(1)
      end
    end

    it "saves the logged in user's id to the session" do
      request.stub(:env).and_return(omniauth_hash)    
      get :create, provider: user.provider
      expect(session[:user_id]).to eq(user.id)
    end

    it 'redirects to an authenticated page' do
      request.stub(:env).and_return(omniauth_hash)    
      get :create, provider: user.provider
      expect(response).to redirect_to('/authenticated')
    end
  end
  
  describe '#destroy', pending: true

  describe '#failure', pending: true
end
