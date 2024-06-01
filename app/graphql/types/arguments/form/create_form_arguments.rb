module Types
  module Arguments
    module Form
      class CreateFormArguments < BaseInputObject
        
        argument :title, String, required: false, default_value: 'no title'
        argument :respond_until, GraphQL::Types::ISO8601DateTime, required: false
        argument :opened, Boolean, required: false, default_value: false
        

      end
    end
  end
end