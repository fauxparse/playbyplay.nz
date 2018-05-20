# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    grant_public_permissions
    grant_user_permissions(user) if user.persisted?
    grant_moderator_permissions if user.moderator?
  end

  private

  def grant_public_permissions
    can :read, Review, state: :published
  end

  def grant_user_permissions(user)
    can :create, Review
    can :update, Review, reviewer_id: user.id
  end

  def grant_moderator_permissions
    can :manage, [Review, Submission]
  end
end
