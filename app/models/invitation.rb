class Invitation < ApplicationRecord
  belongs_to :team
  enum status: [:pending, :accepted, :denied]
  validate :is_a_member_of_the_team, on: :create
  validate :has_an_invitation_pending, on: :create

  def has_an_invitation_pending()
    invitations = Invitation.where(email: self.email  ,team_id: self.team_id, status: :pending)
    errors.add(:email, "already has a pending invitation") if invitations.count > 0
  end

  def is_a_member_of_the_team()
    user = User.where(email: self.email).last
    teamUsers = TeamUser.where(user_id: user.id  ,team_id: self.team_id)
    errors.add(:email, "already is a member") if teamUsers.count > 0 || self.team.user.email == self.email
  end
end
