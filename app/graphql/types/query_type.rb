# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject

    field :forms, resolver: Resolvers::UserForms
    field :form, resolver: Resolvers::GetForm
    field :questions, resolver: Resolvers::FormQuestions
    field :opened_forms, resolver: Resolvers::OpenedForms

    field :user, UserType, null: true do
      argument :id, ID, required: true
    end

    def user(id:)
      ::User.find(id)
    end

  end
end
