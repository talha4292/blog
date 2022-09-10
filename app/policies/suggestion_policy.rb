# frozen_string_literal: true

class SuggestionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def list?
    user
  end

  def show?
    user_is_owner_of_record? || user_is_owner_of_post?
  end

  def edit?
    update?
  end

  def update?
    user_is_owner_of_record? || user_is_owner_of_post?
  end

  def destroy?
    user_is_owner_of_record? || user_is_owner_of_post?
  end

  private

  def user_is_owner_of_record?
    user == @record.user
  end

  def user_is_owner_of_post?
    user == @record.post.user
  end
end
