class TalksController < ApplicationController
  def show
    @talk = Talk.find_by(user_one_id: [params[:id], current_user.id], user_two_id: [params[:id], current_user.id], team: params[:team_id])
    # If talk not yet created
    unless @talk
      @team = Team.find(params[:team_id])
      @user = User.find(params[:id])
      # Check if current_user and user are team members
      if @team.my_users.include? current_user and @team.my_users.include? @user
        @talk = Talk.create(user_one: current_user, user_two: @user, team: @team)
      end
    end
    authorize! :read, @talk
  end
end
