require 'rails_helper'

RSpec.describe TalksController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    request.env['HTTP_ACCEPT'] = 'application/json'

    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
  end

  describe "GET #show" do
    render_views

    before(:each) do
      @team = create(:team)
      @guest_user = create(:user)
      @team.users << @guest_user
      @talk = create(:talk, user_one: @current_user, user_two: @guest_user, team: @team)
      @message1 = build(:message)
      @message2 = build(:message)
      @talk.messages << [@message1, @message2]
      get :show, params: {id: @guest_user, team_id: @team.id}
    end

    context 'Is talk member' do
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it 'Returns the right params' do
        response_hash = JSON.parse(response.body)
        expect(response_hash["user_one_id"]).to eql(@current_user.id)
        expect(response_hash["user_two_id"]).to eql(@guest_user.id)
        expect(response_hash["team_id"]).to eql(@team.id)
      end

      it 'return the right number of messages' do
        response_hash = JSON.parse(response.body)
        expect(response_hash["messages"].count).to eql(2)
      end

      it 'return the right messages' do
        response_hash = JSON.parse(response.body)
        expect(response_hash["messages"][0]["body"]).to eql(@message1.body)
        expect(response_hash["messages"][0]["user_id"]).to eql(@message1.user_id)
        expect(response_hash["messages"][1]["body"]).to eql(@message2.body)
        expect(response_hash["messages"][1]["user_id"]).to eql(@message2.user_id)
      end
    end

    context 'Isn\'t talk member' do
      it 'returns http forbidden' do
        @team = create(:team)
        @guest_user = create(:user)
        @team.users << @guest_user
        @talk = create(:talk, user_two: @guest_user, team: @team)
        get :show, params: {id: @guest_user, team_id: @team.id}
        expect(response).to have_http_status :forbidden
      end
    end

  end

end
