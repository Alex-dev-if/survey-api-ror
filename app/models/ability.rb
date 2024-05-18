# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.adm?
      # can :create, Survey
      # can :update, Survey
      # can :delete, Survey
      # can :read, Survey
    else
      # can :read, Survey
    end
  end
end
