module Queries
  class FormAnswers < Queries::BaseQuery
    description: 'Search all answers for a form and the quantity of answers'

    argument :form_id, ID, required: true

    field :answers, [Types::AnswerType], null: false
    field :answers_quantity, Integer, null: false

    def resolve(args)
      answers = ::Answer.where(args)
      answers_quantity = ::Answer.where(args).count

      {answers: answers, answers_quantity: answers_quantity}
    end
  end
end
