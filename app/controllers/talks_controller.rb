class TalksController < ApplicationController
  def show
    @talk = Talk.find_by(user_one_id: [params[:id], current_user.id], user_two_id: [params[:id], current_user.id], team: params[:team_id])
    authorize! :read, @talk
  end
end
