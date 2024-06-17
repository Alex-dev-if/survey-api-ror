module Mutations
  module Questions
    class DeleteQuestion < BaseMutation

      argument :id, ID, required: true
    
      def resolve(id:)

        auth(:delete, Question, id)

        Question::Deleter.call(id)
        
      end
    end
  end
end