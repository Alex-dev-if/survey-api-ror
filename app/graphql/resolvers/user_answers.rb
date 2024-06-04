module Resolvers
  class UserAnswers < BaseResolver
    description 'Search all answers for an user'


    type [Types::AnswerType], null: false

    def resolve()
      user = context[:current_user]

      answers = []
      answers.concat(user.forms.flat_map {|form| form.questions.flat_map(&:answers)})

    end
  end
end
