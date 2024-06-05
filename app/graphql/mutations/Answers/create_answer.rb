module Mutations
  module Answers
    class CreateAnswer < BaseMutation
      argument :answers, [Types::Arguments::CreateAnswerArguments], required: true
    
      field :answers, [Types::AnswerType], null: true
      field :errors, [String], null: true
      def resolve(args)
        user_id = context[:current_user].id unless context[:current_user].nil?

        answers = Answer::Creator.call(args, user_id)

        saved_answers = []
        errors = []
        answers.each_with_index do |answer, idx|
          if answer.save
             saved_answers << answer
          else
            answer_errors = answer.errors.full_messages.join(", ")
            answer_errors = "answer #{idx+1}: #{answer_errors}"
            errors << answer_errors
          end
        end
        
        {answers: saved_answers, errors: errors}

      end
    end
  end
end