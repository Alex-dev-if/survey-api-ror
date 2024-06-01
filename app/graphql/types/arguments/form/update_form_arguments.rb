module Types
  module Arguments
    module Form
      class UpdateFormArguments < BaseInputObject

        argument :title, String, required: false
        argument :respond_until, GraphQL::Types::ISO8601DateTime, required: false
        argument :opened, Boolean, required: false
        argument :id, ID, required: true

      end
    end
  end
end