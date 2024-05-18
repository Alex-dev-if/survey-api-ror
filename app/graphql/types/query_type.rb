# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false

    def users
      User.all
    end

    field :current_user, String, null: false

    def current_user
      context[:current_user] || "guest"
    end
  end
end
