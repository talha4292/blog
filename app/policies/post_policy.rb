# frozen_string_literal: true

# PostPolicy
class PostPolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user
  end

  def approve?
    user_is_moderator_or_admin?
  end

  def show?
    user_is_owner_of_record? || user_is_moderator_or_admin? || @record.approved?
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def create?
    user
  end

  def update?
    user_is_owner_of_record? || user_is_moderator_or_admin?
  end

  def destroy?
    user_is_owner_of_record?
  end

  private

  def user_is_owner_of_record?
    user == @record.user
  end

  def user_is_moderator_or_admin?
    user.moderator? || user.admin?
  end
end
