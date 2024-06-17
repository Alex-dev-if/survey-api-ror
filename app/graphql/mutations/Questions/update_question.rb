module Mutations
  module Questions
    class UpdateQuestion < BaseMutation
      
      input_object_class Types::Arguments::Question::UpdateQuestionArguments
    
      field :question, Types::QuestionType, null: true

      def resolve(args)

        auth(:update, Question, args[:id])
        
        question = Question::Updater.call(args)
        question.rearrange

        if question.update(args)
          {question: question}
        else
          raise GraphQL::ExecutionError, question.errors.full_messages.join(", ")
        end
      end
    end
  end
end