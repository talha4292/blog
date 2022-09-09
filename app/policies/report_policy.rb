# frozen_string_literal: true

# ReportPolicy
class ReportPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def new?
    create?
  end

  def post_report?
    user_is_moderator_or_admin?
  end

  def comment_report?
    user_is_moderator_or_admin?
  end

  def create?
    !user_is_owner_of_record?
  end

  private

  def user_is_owner_of_record?
    user == @record.user
  end

  def user_is_moderator_or_admin?
    user.moderator? || user.admin?
  end
end
