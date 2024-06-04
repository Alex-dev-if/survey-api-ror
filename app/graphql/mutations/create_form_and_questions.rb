module Mutations
  class CreateFormAndQuestions < BaseMutation
    description 'create a form and your questions in the same query'
    
    argument :form, Types::Arguments::Form::CreateFormArguments, required: true
    argument :questions, [Types::Arguments::CreateQuestionsWithForm], required: true

    field :form, Types::FormType, null: true
    field :questions, [Types::QuestionType], null: true
    
    def resolve(args)

      auth(:create, Form)

      args[:form] = args[:form].to_h.merge(user_id: context[:current_user].id)
      
      raise GraphQL::ExecutionError, "Maximum limit of ten questions per form" unless args[:questions].count <= 10
      raise GraphQL::ExecutionError, "Order greather than number of questions" unless args[:questions].all? {|question| question.order <= args[:questions].count}

      form = Form::Creator.call(args[:form])

      if form.save 
        errors = []

        args[:questions].each do |question|

          question = question.to_h.merge(form_id: form.id)

          question = Question::Creator.call(question)
          question.save

          if !question.save
            raise GraphQL::ExecutionError, question.errors.full_messages.join(", ")
          end   
        end
        {form: form, questions: form.questions}
      else
        raise GraphQL::ExecutionError, form.errors.full_messages.join(", ")
      end
    end
  end
end

