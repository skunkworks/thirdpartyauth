class SessionsController < ApplicationController
  # Open question: what happens if user changes info on Facebook? If they reauthenticate
  # with our app, do we get a new info hash?
  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth[:provider], auth[:uid]) ||
           User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to authenticated_path
  end

end
