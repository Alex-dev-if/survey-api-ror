module Queries
  class UserForms < Queries::BaseQuery Queries::BaseQuery
    description 'Search all forms for a user'


    type [Types::FormType], null: false

    def resolve()
      ::Form.where(user: context[:current_user])
    end
  end
end
