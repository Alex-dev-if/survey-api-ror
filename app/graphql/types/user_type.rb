# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String
    field :password_digest, String
    field :role, String
    field :forms, FormType.connection_type, null: false
    field :answers, AnswerType.connection_type, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

  end
end
