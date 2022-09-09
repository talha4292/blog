# frozen_string_literal: true

# LikePolicy
class LikePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user
  end

  def destroy?
    user
  end
end
