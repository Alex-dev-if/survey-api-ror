module Resolvers
  class OpenedForms < BaseResolver
    description 'Search all opened forms for a user'

    type [Types::FormType], null: false

    def resolve()
      ::Form.where(user: context[:current_user], opened: true)
    end
  end
end
