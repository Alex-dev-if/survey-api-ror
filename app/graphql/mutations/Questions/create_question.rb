module Mutations
  module Questions
    class CreateQuestion < BaseMutation

      input_object_class Types::Arguments::Question::CreateQuestionArguments
    
      field :question, Types::QuestionType, null: true

      def resolve(args)

        auth(:create, Question, args[:form_id])
        question = Question::Creator.call(args)

        if question.save(context: :question_without_form)
          {question: question}
        else
          raise GraphQL::ExecutionError, question.errors.full_messages.join(", ")
        end
      end
    end
  end
end