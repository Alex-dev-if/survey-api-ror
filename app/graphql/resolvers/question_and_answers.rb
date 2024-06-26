module Resolvers
  class QuestionAndAnswers < BaseResolver
    description 'A question, your answers, quantity of answers'

    argument :id, ID, required: true
    type Types::QuestionType, null: false

    def resolve(id:)
      auth(:manage, Question, id)
      ::Question.find id
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, e
    end
  end
end
