class InvitationsController < ApplicationController
  def create
    @invitation = Invitation.new(invitation_params)
    authorize! :create, @invitation
    if @invitation.save
      render json: @invitation, status: :created
    end
  end

  def update
    @invitation = Invitation.find(params[:id])
    authorize! :update, @invitation
    if @invitation.update(invitation_params)
      render json: @invitation
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :team_id, :status)
  end
end
