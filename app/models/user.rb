class User < ActiveRecord::Base
  validates :provider, presence: true
  validates :uid, presence: true
  validates :token, presence: true

  # TODO: figure out how token expiration works
  def self.create_with_omniauth(auth)
    user = User.create(name:       auth[:info][:name], 
                       email:      auth[:info][:email],
                       provider:   auth[:provider],
                       uid:        auth[:uid],
                       token:      auth[:credentials][:token],
                       avatar_url: auth[:info][:image])
  end

end
