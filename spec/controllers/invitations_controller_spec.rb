require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    request.env['HTTP_ACCEPT'] = 'application/json'
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
  end

  describe 'POST #create' do
    render_views

    context 'Invitation has sent by Team\'s Owner' do
      it 'returns http success' do
        @team = create(:team, user_id: @current_user.id)
        @invitation = attributes_for(:invitation)
        post :create, params: { invitation: {email: @invitation[:email], team_id: @team.id, status: @invitation[:status]} }
        expect(response).to have_http_status(:success)
      end

      it 'the quantity is increased by 1' do
        @team = create(:team, user_id: @current_user.id)
        @invitation = attributes_for(:invitation, team_id: @team.id)
        expect {
          post :create, params: {
            invitation: {
              email: @invitation[:email],
              team_id: @invitation[:team_id],
              status: @invitation[:status]
            }
          }
        }.to change(Invitation, :count).by(1)
      end
    end

    context 'Invitation has sent by another user' do
      it 'returns http forbidden' do
        @team = create(:team)
        @invitation = attributes_for(:invitation, team_id: @team.id)
        expect {
          post :create, params: {
            invitation: {
              email: @invitation[:email],
              team_id: @invitation[:team_id],
              status: @invitation[:status]
            }
          }
        }.to change(Invitation, :count).by(0)
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  context 'PUT #update' do
    context 'As a Owner' do
      it 'returns http success' do
        @team = create(:team, user_id: @current_user.id)
        @invitation = create(:invitation, team_id: @team.id)
        @invitation_updated = attributes_for(:invitation, team_id: @team.id )
        put :update, params: { id: @invitation.id, invitation: @invitation_updated }
        expect(response).to have_http_status :success
      end

      it 'Invitation has updated attributes' do
        @team = create(:team, user_id: @current_user.id)
        @invitation = create(:invitation, team_id: @team.id)
        @invitation_updated = attributes_for(:invitation, team_id: @team.id )
        put :update, params: { id: @invitation.id, invitation: @invitation_updated }
        expect(Invitation.last.email).to eq(@invitation_updated[:email])
        expect(Invitation.last.status).to match("#{@invitation_updated[:status]}")
        expect(Invitation.last.team_id).to eq(@invitation_updated[:team_id])
      end
    end

    context 'As a member Invited' do
      it 'return http success' do
        @team = create(:team)
        @invitation = create(:invitation, email: @current_user.email)
        @invitation_updated = attributes_for(:invitation, email: @invitation.email, team_id: @invitation.team_id, status: :accepts)
        put :update, params: { id: @invitation.id, invitation: @invitation_updated }
        expect(response).to have_http_status(:success)
      end

      it 'change status to accepts' do
        @team = create(:team)
        @invitation = create(:invitation, email: @current_user.email)
        @invitation_updated = attributes_for(:invitation, email: @invitation.email, team_id: @invitation.team_id, status: :accepts)
        put :update, params: { id: @invitation.id, invitation: @invitation_updated }
        expect(response).to have_http_status(:success)
        expect(Invitation.last.status).to match("#{@invitation_updated[:status]}")
      end
    end

    context 'The user isn\'t a Member neither a member invited' do
        it 'returns http forbidden' do
          @team = create(:team)
          @invitation = create(:invitation)
          @invitation_updated = attributes_for(:invitation, email: @invitation.email, team_id: @invitation.team_id, status: :accepts)
          put :update, params: { id: @invitation.id, invitation: @invitation_updated }
          expect(response).to have_http_status(:forbidden)
        end
    end
  end
end
