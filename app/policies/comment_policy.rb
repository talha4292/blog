# frozen_string_literal: true

# CommentPolicy
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

  def destroy?
    user_is_owner_of_record?
  end

  private

  alias create? show?

  def user_is_owner_of_record?
    user == @record.user
  end
end
