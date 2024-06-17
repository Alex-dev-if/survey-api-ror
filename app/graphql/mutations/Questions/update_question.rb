module Mutations
  module Questions
    class UpdateQuestion < BaseMutation
      
      input_object_class Types::Arguments::Question::UpdateQuestionArguments
    
      field :question, Types::QuestionType, null: true

      def resolve(args)

        auth(:update, Question, args[:id])
        
        question = Question::Updater.call(args)

      end
    end
  end
end