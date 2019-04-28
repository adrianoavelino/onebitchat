require 'rails_helper'

RSpec.describe ChannelsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    request.env['HTTP_ACCEPT'] = 'application/json'
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
  end

  describe 'POST #create' do
    render_views

    context 'User is Team Member' do
      it 'returns http success' do
        @team = create(:team)
        @team.users << @current_user

        @channel_attributes = attributes_for(:channel, team: @team, user_id: @current_user.id)
        post :create, params: {channel: @channel_attributes.merge(team_id: @team.id)}
        expect(response).to have_http_status(:success)
      end

      it 'the Channel quantity is increased by 1' do
        @team = create(:team)
        @team.users << @current_user
        @channel_attributes = attributes_for(:channel, team_id: @team.id, user_id: @current_user.id)
        channel_amount = Channel.count

        post :create, params: {channel: @channel_attributes}
        expect(Channel.count).to eq channel_amount + 1
      end

      it 'Channel is created with right params' do
        @team = create(:team)
        @team.users << @current_user

        @channel_attributes = attributes_for(:channel, user_id: @current_user.id)
        post :create, params: {channel: @channel_attributes.merge(team_id: @team.id)}
        channel_created = Channel.where({slug: @channel_attributes[:slug]})

        expect(channel_created.last[:slug]).to eql(@channel_attributes[:slug])
        expect(channel_created.last[:user]).to eql(@channel_attributes[:user])
        expect(channel_created.last[:team]).to eql(@channel_attributes[:team])
      end

      it 'Return right values to channel' do
        @team = create(:team)
        @team.users << @current_user
        @channel_attributes = attributes_for(:team, user_id: @current_user.id, team_id: @team.id)
        post :create, params: {channel: @channel_attributes}
        response_hash = JSON.parse(response.body)

        expect(response_hash["slug"]).to eql(@channel_attributes[:slug])
        expect(response_hash["team_id"]).to eql(@channel_attributes[:team_id])
        expect(response_hash["user_id"]).to eql(@channel_attributes[:user_id])
      end
    end

    context 'User isn\'t Team Member' do
      it 'returns http forbidden' do
        @team = create(:team)
        user = create(:user)
        @channel_attributes = attributes_for(:channel, team_id: @team.id, user_id: user.id)
        post :create, params: {channel: @channel_attributes}
        # expect(Channel.count).to eq 2
        expect(response).to have_http_status(:forbidden)
      end
    end

  end
end
