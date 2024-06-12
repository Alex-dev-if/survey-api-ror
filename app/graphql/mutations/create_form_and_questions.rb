module Mutations
  class CreateFormAndQuestions < BaseMutation
    description 'create a form and your questions in the same query'
    
    argument :form, Types::Arguments::Form::CreateFormArguments, required: true
    argument :questions, [Types::Arguments::CreateQuestionsWithForm], required: true

    field :form, Types::FormType, null: true
    field :questions, [Types::QuestionType], null: true
    field :errors, [String], null: true

    def resolve(args)

      auth(:create, Form)

      args[:form] = args[:form].to_h.merge(user_id: context[:current_user].id)
      
      CreateFormAndQuestionsService.call(args[:form], args[:questions])

    end
  end
end

