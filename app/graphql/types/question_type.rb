# frozen_string_literal: true

module Types
  class QuestionType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :question_type, String
    field :required, Boolean
    field :options, [String]
    field :form_id, Integer
    field :order, Integer
    field :answers, AnswerType.connection_type, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
