# frozen_string_literal: true

class Ability
  include CanCan::Ability
  
  def initialize(user)
    if user&.adm?
      can :create, :all
      can :delete, :all
      can :read, :all
      can :update, Form, user: user
      can :delete, Question
    else
      can :read, :all
      can :create, Answer
    end
    
  end
end
