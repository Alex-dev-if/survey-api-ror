module Resolvers
  class ClosedForms < BaseResolver
    description 'Search all closed forms for a user'

    type [Types::FormType], null: false

    def resolve()
      context[:current_user].forms.closed
    end
  end
end
