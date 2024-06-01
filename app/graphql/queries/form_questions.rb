module Queries
  class FormQuestions < Queries::BaseQuery
    description: 'Search all questions for a form'

    argument :form_id, ID, required: true

    type [Types::QuestionType], null: false

    def resolve(args)
      ::Question.where(args)
    end
  end
end
