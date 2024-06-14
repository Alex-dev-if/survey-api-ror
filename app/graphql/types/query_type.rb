# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject

    field :closed_forms, resolver: Resolvers::ClosedForms
    field :form_and_items, resolver: Resolvers::FormAndItems
    field :opened_forms, resolver: Resolvers::OpenedForms
    field :question_and_answers, resolver: Resolvers::QuestionAndAnswers
    field :results, resolver: Resolvers::Results
    field :user_and_items, resolver: Resolvers::UserAndItems

  end
end
