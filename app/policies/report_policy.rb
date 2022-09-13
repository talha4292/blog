# frozen_string_literal: true

# ReportPolicy
class ReportPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user_is_moderator_or_admin?
  end

  def new?
    user
  end

  def create?
    user != @record.reportable.user
  end

  private

  def user_is_moderator_or_admin?
    user.moderator? || user.admin?
  end
end
