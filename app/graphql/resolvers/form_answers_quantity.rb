module Resolvers
  class FormAnswersQuantity < BaseResolver
    description 'Returns the number of answers from a form'

    argument :form_id, ID, required: true

    type Integer, null: false


    def resolve(form_id:)
      form = Form.find form_id
      auth(:manage, form)

      form.questions.flat_map(&:answers).count

    end
  end
end
