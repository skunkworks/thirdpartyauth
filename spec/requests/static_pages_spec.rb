require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe 'home page' do
    before { visit root_path }

    context 'when not logged in' do
      it { should have_link('Connect with Facebook', href: '/auth/facebook') }
    end

    context 'when logged in' do
      # TODO: How do we use capybara to log in to Facebook? Should we create a test user?
      #
      # before do
      #   click_link 'Connect with Facebook'
      # end
      # it { should have_link('click here to log out', href: '/signout') }
    end
  end

  # it "creates a Widget and redirects to the Widget's page" do
  #   get "/widgets/new"
  #   expect(response).to render_template(:new)

  #   post "/widgets", :widget => {:name => "My Widget"}

  #   expect(response).to redirect_to(assigns(:widget))
  #   follow_redirect!

  #   expect(response).to render_template(:show)
  #   expect(response.body).to include("Widget was successfully created.")
  # end

end