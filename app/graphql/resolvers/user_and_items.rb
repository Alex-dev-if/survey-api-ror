module Resolvers
  class UserAndItems < BaseResolver
    description 'An user, your items(forms or answers), quantity of items'

    type Types::UserType, null: false

    def resolve()
      context[:current_user]
    end
  end
end
