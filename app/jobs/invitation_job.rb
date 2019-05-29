class InvitationJob < ApplicationJob
  queue_as :emails

  def perform(invitation)
    InvitationMailer.invitation(invitation).deliver_now
  end
end
