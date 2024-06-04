module Resolvers
  class UserAndForms < BaseResolver
    description 'An user, your forms, quantity of forms'


    type Types::UserType, null: false

    def resolve()
      context[:current_user]
    end
  end
end
