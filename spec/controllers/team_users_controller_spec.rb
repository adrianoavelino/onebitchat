require 'rails_helper'

RSpec.describe TeamUsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
  end
  describe 'POST#create' do
    context 'Team owner' do
      it 'returns http success' do
        @team = create(:team, user: @current_user)
        @guest_user = create(:user)
        post :create, params: {team_user: {user_id: @current_user.id, team_id: @team.id}}
        expect(response).to have_http_status(:success)
      end
    end

    context "Team not owner" do
      before(:each) do
        @team = create(:team)
        @guest_user = create(:user)
        @team.users << @current_user
        @team.users << @guest_user
      end

      it "returns http forbidden" do
        post :create, params: { team_user: { user_id: @guest_user.id, team_id: @team.id } }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  context 'DELETE#destroy' do
    context 'Team owner' do
      it 'returns http success' do
        @team = create(:team, user: @current_user)
        @guest_user = create(:user)
        @team.users << @guest_user

        expect { delete :destroy,
                 params: {
                   id: @guest_user.id,
                   team_id: @team.id
                  }
                }.to change(TeamUser, :count).by(-1)
        expect(response).to have_http_status(:success)
      end
    end

    context 'Team not owner' do
      it 'returns http forbidden' do
        @team = create(:team)
        @guest_user = create(:user)
        @team.users << @guest_user

        expect { delete :destroy,
                 params: {
                   id: @guest_user.id,
                   team_id: @team.id
                  }
                }.to change(TeamUser, :count).by(0)
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
