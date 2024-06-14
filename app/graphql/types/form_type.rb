# frozen_string_literal: true

module Types
  class FormType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :user_id, Integer, null: false
    field :respond_until, GraphQL::Types::ISO8601DateTime
    field :opened, Boolean
    field :questions, QuestionType.connection_type, null: false
    field :answers, AnswerType.connection_type, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
