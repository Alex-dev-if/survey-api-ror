module Resolvers
  class FormAndItems < BaseResolver
    description 'A form, your items(questions, answers), quantity of items'

    argument :id, ID, required: true
    type Types::FormType, null: false

    def resolve(id:)
      form = ::Form.find id
      raise GraphQL::ExecutionError, "Response time expired" unless form.permit_reply
      form.open
      form

    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, e
    end
  end
end
