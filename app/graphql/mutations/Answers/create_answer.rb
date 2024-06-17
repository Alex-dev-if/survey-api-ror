module Mutations
  module Answers
    class CreateAnswer < BaseMutation
      argument :answers, [Types::Arguments::CreateAnswerArguments], required: true
    
      field :answers, [Types::AnswerType], null: true
      field :errors, [String], null: true
      def resolve(args)
        # passando o user_id se existir
        args[:user_id] = context[:current_user].id unless context[:current_user].nil? 
        Answer::Creator.call(args)
      end
    end
  end
end