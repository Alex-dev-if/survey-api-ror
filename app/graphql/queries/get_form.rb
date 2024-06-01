module Queries
  class GetForm < Queries::BaseQuery
    description: 'Fetch form for some id'

    argument :id, ID, required: true

    type Types::FormType, null: false

    def resolve(id:)
      form = ::Form.find(id)
      if form.permit_reply == false
        raise GraphQL::ExecutionError, "Response time expired"
      end
      form
    end
  end
end
