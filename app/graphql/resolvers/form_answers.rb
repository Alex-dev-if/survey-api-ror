module Resolvers
  class FormAnswers < BaseResolver
    description 'Search all answers for a form'

    argument :form_id, ID, required: true

    type [Types::AnswerType], null: false

    def resolve(form_id:)
      form = Form.find form_id
      auth(:manage, form)

      form.questions.flat_map(&:answers)

    end
  end
end
