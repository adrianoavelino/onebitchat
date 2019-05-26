# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :read, Team do |t|
        t.user_id == user.id || t.users.where(id: user.id).present?
      end

      can :destroy, Team do |t|
        t.user_id == user.id
      end

      can [:read, :create], Channel do |c|
        c.team.user_id == user.id || c.team.users.where(id: user.id).present?
      end

      can [:destroy, :update], Channel do |c|
        c.team.user_id == user.id || c.user_id == user.id
      end

      can [:read], Talk do |t|
        t.user_one_id == user.id || t.user_two_id == user.id
      end

      can [:create], TeamUser do |t|
        t.team.user_id == user.id || user.email == t.user.email
      end

      can [:destroy], TeamUser do |t|
        t.team.user_id == user.id || t.user.id == user.id
      end

      can [:create], Invitation do |i|
        Team.find(i.team_id).user_id == user.id
      end

      can [:update], Invitation do |i|
        Team.find(i.team_id).user_id == user.id || user.email == i.email
      end
    end
  end
end
