# frozen_string_literal: true

# SuggestionPolicy
class SuggestionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user
  end

  def show?
    user_is_owner_of_record? || user_is_owner_of_post?
  end

  def create?
    user != @record.post.user
  end

  def update?
    user_is_owner_of_record?
  end

  def destroy?
    user_is_owner_of_record?
  end

  private

  alias new? index?
  alias edit? update?

  def user_is_owner_of_record?
    user == @record.user
  end

  def user_is_owner_of_post?
    user == @record.post.user
  end
end
