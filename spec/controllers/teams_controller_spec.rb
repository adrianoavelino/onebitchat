require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    context 'team exists' do
      context 'User is the owner of the team' do
        it 'returns success' do
          another_user = create(:user)
          team = create(:team, user: @current_user)
          get :show, params: {slug: team.slug}
          expect(response).to have_http_status(:success)
        end
        context 'User is member of the team' do
          it 'Returns success' do
            team = create(:team)
            team.users << @current_user
            get :show, params: {slug: team.slug}
            expect(response).to have_http_status(:success)
          end
        end
        context "User is not the owner or member of the team" do
          it "Redirects to root" do
            team = create(:team)
            get :show, params: {slug: team.slug}
            
            expect(response).to redirect_to('/')
          end
        end
      end
    end
  end

end
