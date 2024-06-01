module Types
  module Arguments
    class CreateAnswerArguments < BaseInputObject
      
      argument :content, GraphQL::Types::JSON, required: false
      argument :question_id, Integer, required: true
      
    end
  end
end