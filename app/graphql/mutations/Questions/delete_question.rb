module Mutations
  module Questions
    class DeleteQuestion < BaseMutation

      argument :id, ID, required: true
    
      def resolve(id:)

        auth(:delete, Question, id)

        question = Question::Deleter.call(id)

        if question.destroyed?
          {success: true}
        else
          raise GraphQL::ExecutionError, question.errors.full_messages.join(", ")
        end
        
      end
    end
  end
end