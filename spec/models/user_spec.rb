require 'spec_helper'

describe User do
  let (:user) { User.new }
  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:provider) }
  it { should respond_to(:uid) }
  it { should respond_to(:token) }
  it { should respond_to(:avatar_url) }

end
