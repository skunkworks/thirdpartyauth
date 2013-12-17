require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe 'home page' do
    before { visit root_path }

    context 'when not logged in' do
      it { should have_link('Connect with Facebook', href: '#') }
    end

    describe 'authentication process' do
      before do
        click_link 'Connect with Facebook'
        # fill_in ''
      end
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