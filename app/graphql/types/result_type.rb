# frozen_string_literal: true

module Types
  class ResultType < Types::BaseObject
    field :question_title, String, null: false
    field :content, GraphQL::Types::JSON, null: false
  end
end
