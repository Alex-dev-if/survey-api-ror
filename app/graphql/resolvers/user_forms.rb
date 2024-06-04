module Resolvers
  class UserForms < BaseResolver
    description 'Search forms for a user'


    type [Types::FormType], null: false

    def resolve()
      ::Form.where(user: context[:current_user])
    end
  end
end
