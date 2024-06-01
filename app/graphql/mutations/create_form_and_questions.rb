module Mutations
  class CreateFormAndQuestions < BaseMutation

    argument :form, Types::Arguments::Form::CreateFormArguments, required: true
    argument :questions, [Types::Arguments::CreateQuestionsWithForm], required: true

    field :errors, [String], null: true
    field :form, Types::FormType, null: true
    field :questions, [Types::QuestionType], null: true
    
    def resolve(args)

      authorize! :create, Form
      authorize! :create, Question

      args[:form] = args[:form].to_h.merge(user_id: context[:current_user].id)

      return {errors: ["Maximum limit of ten questions per form"]} unless args[:questions].count <= 10
      return {errors: ["Order greather than number of questions"]} unless args[:questions].all? {|question| question.order <= args[:questions].count}

      form = Form::Creator.call(args[:form])

      if form.save 
        errors = []

        args[:questions].each do |question|

          question = question.to_h.merge(form_id: form.id)
        
          question = Question::Creator.call(question)

          if !question.save
            errors << question.errors.full_messages  
          end   

        end
        {form: form, questions: form.questions, errors: errors}
      else
        {errors: form.errors.full_messages}
      end
    end
  end
end

