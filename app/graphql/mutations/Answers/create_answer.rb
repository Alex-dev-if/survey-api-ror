module Mutations
  module Answers
    class CreateAnswer < BaseMutation

      input_object_class Types::Arguments::CreateAnswerArguments
    
      field :errors, [String], null: true
      field :answer, Types::AnswerType, null: true

      def resolve(args)

        authorize! :create, Answer
        args[:user_id] = context[:current_user].id

        answer = Answer::Creator.call(args)

        if answer.save
          {answer: answer}
        else
          {errors: answer.errors.full_messages}      
        end
      end
    end
  end
end