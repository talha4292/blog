# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    user
  end

  def view?
    user.moderator? || user.admin?
  end

  def create?
    user
  end

  def destroy?
    user == @record.user
  end
end
