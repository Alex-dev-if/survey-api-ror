module Resolvers
  class GetForm < BaseResolver
    description 'Fetch form for some id'

    argument :id, ID, required: true

    type Types::FormType, null: false

    def resolve(id:)
      form = ::Form.find(id)
      raise GraphQL::ExecutionError, "Response time expired" unless form.permit_reply
      form
    end
  end
end
