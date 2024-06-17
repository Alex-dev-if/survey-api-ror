module Mutations
  module Questions
    class CreateQuestion < BaseMutation

      input_object_class Types::Arguments::Question::CreateQuestionArguments
    
      field :question, Types::QuestionType, null: true

      def resolve(args)

        auth(:create, Question, args[:form_id])
        Question::Creator.call(args)

      end
    end
  end
end