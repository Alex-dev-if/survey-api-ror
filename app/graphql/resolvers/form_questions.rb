module Resolvers
  class FormQuestions < BaseResolver
    description 'Search all questions for a form'

    argument :form_id, ID, required: true

    type [Types::QuestionType], null: false

    def resolve(args)
      form = Form.find args[:form_id]
      auth(:manage, form)

      ::Question.where(args)
    end
  end
end
