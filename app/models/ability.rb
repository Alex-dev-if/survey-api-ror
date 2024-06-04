# frozen_string_literal: true

class Ability
  include CanCan::Ability
  
  def initialize(user)
    if user&.adm?
      can :create, :all
      can :read, :all
      can :update, Question
      can :manage, Question
      can [:update, :delete, :manage], Form, user: user
      can :update, Answer
    else
      can :read, :all
      can [:create, :update], Answer
    end
    
  end
end
