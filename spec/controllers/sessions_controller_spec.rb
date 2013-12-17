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

    it 'redirects to the home page' do
      request.stub(:env).and_return(omniauth_hash)    
      get :create, provider: user.provider
      expect(response).to redirect_to(root_path)
    end

    it 'sets a flash message' do
      request.stub(:env).and_return(omniauth_hash)
      get :create, provider: user.provider
      expect(flash[:notice]).to eq('Logged in successfully')      
    end
  end
  
  describe '#destroy' do
    it "deletes the logged in user's id from the session" do
      session[:user_id] = 1
      delete :destroy 
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the home page' do
      delete :destroy 
      expect(response).to redirect_to(root_path)
    end

    it 'sets a flash message' do
      delete :destroy 
      expect(flash[:notice]).to eq("You've been logged out")      
    end
  end

  describe '#failure' do
    # it 'redirects to the home page' do 
    #   get :failure, provider: user.provider
    #   expect(response).to redirect_to('/authenticated')
    # end

    # it 'sets a flash message' do
    #   request.stub(:env).and_return(omniauth_hash)
    #   get :create, provider: user.provider
    #   expect(flash[:notice]).to eq('Logged in successfully')      
    # end
  end
end
