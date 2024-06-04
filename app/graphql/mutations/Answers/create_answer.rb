module Mutations
  module Answers
    class CreateAnswer < BaseMutation
      input_object_class Types::Arguments::CreateAnswerArguments
    
      field :answer, Types::AnswerType, null: true

      def resolve(args)
        authorize! :create, Answer
        args[:user_id] = context[:current_user].id unless context[:current_user].nil?

        answer = Answer::Creator.call(args)

        if answer.save
          {answer: answer}
        else
          raise GraphQL::ExecutionError, answer.errors.full_messages.join(", ")
        end
      end
    end
  end
end