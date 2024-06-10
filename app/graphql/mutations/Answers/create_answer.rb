module Mutations
  module Answers
    class CreateAnswer < BaseMutation
      argument :answers, [Types::Arguments::CreateAnswerArguments], required: true
      argument :form_id, ID, required: true

      field :answers, [Types::AnswerType], null: true
      field :errors, [String], null: true

      def resolve(args)

        result = Answer::Creator.call(args, args[:form_id], context[:current_user])

        if result[:errors].blank?
          {answers: result[:answers]}
        else
          {errors: result[:errors]}
        end
      end
    end
  end
end