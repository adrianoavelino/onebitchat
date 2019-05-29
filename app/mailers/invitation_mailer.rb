class InvitationMailer < ApplicationMailer
  def invitation(invitation)
    @invitation = invitation
    @team = Team.find(@invitation.team_id)
    mail to: @invitation.email, subject: "OneBitChat Invitation"
  end
end
