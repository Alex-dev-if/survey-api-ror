module Mutations
  module Questions
    class UpdateQuestion < BaseMutation
      
      input_object_class Types::Arguments::Question::UpdateQuestionArguments
    
      field :errors, [String], null: true
      field :question, Types::QuestionType, null: true

      def resolve(args)

        authorize! :update, Question

        question = Question.find args[:id]
        form = Form.find question.form_id
        authorize! :update, form

        question = Question::Updater.call(args)
        question.rearrange(question.order)

        test = Question.new(args)
        if context[:current_user] != form.user
          {errors: ["You aren't authorized because are not the owner"]} 
        elsif test.valid?(:question_without_form)
          if question.update(args)
            {question: question}
          else
            {errors: question.errors.full_messages}
          end
        else
          {errors: test.errors.full_messages}      
        end
      end
    end
  end
end