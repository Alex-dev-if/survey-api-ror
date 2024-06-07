module Resolvers
  class OpenedForms < BaseResolver
    description 'Search all opened forms for a user'

    type [Types::FormType], null: false

    def resolve()
      user = context[:current_user]
      user.forms.opened
    end
  end
end
