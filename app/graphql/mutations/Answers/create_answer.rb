module Mutations
  module Answers
    class CreateAnswer < BaseMutation
      argument :answers, [Types::Arguments::CreateAnswerArguments], required: true
      argument :form_id, ID, required: true

      field :answers, [Types::AnswerType], null: true
      field :errors, [String], null: true

      def resolve(args)

        args[:user_id] = context[:current_user].id unless context[:current_user].nil?
        Answer::Creator.call(args)

      end
    end
  end
end