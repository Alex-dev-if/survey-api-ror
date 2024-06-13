# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject

    field :form_and_questions, resolver: Resolvers::FormAndQuestions
    field :form_answers_quantity, resolver: Resolvers::FormAnswersQuantity
    field :form_answers, resolver: Resolvers::FormAnswers
    field :form_questions, resolver: Resolvers::FormQuestions
    field :opened_forms, resolver: Resolvers::OpenedForms
    field :question_and_answers, resolver: Resolvers::QuestionAndAnswers
    field :user_and_forms, resolver: Resolvers::UserAndForms
    field :user_answers, resolver: Resolvers::UserAnswers
    field :user_forms, resolver: Resolvers::UserForms
    field :results, resolver: Resolvers::Results

  end
end
