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

  describe 'POST #create' do
    before(:each) do
      @team_attributes = attributes_for(:team, user: @current_user)
      post :create, params: {team: @team_attributes}
    end

    it 'Redirect to new team' do
      expect(response).to have_http_status(:found)
    end

    it 'Create team with right attributes' do
      expect(Team.last.user).to eql(@current_user)
      expect(Team.last.slug).to eql(@team_attributes[:slug])
    end
  end

  describe 'DELETE #destroy' do
    context 'User is the Team Owner' do
      it 'Returns http success' do
        request.env['HTTP_ACCEPT'] = 'application/json'
        team = create(:team, user: @current_user)
        delete :destroy, params: {id:team.id}
        expect(response).to have_http_status(:success)
        expect(Team.count).to eq 0
      end
    end

    context 'User isn\'t the team Owner' do
      it 'returns http forbidden' do
        request.env['HTTP_ACCEPT'] = 'application/json'
        team = create(:team )
        delete :destroy, params: {id: team.id}
        expect(response).to have_http_status(:forbidden)
        # byebug
      end
    end

    context "User is member of the team" do
      it "returns http forbidden" do
        request.env['HTTP_ACCEPT'] = 'application/json'
        team = create(:team)
        team.users << @current_user
        delete :destroy, params: {id: team.id}
        expect(response).to have_http_status(:forbidden)
      end
    end

  end
end
