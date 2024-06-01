module Mutations
  module Questions
    class CreateQuestion < BaseMutation

      input_object_class Types::Arguments::Question::CreateQuestionArguments
    
      field :errors, [String], null: true
      field :question, Types::QuestionType, null: true

      def resolve(args)

        authorize! :create, Question
        
        form = Form.find args[:form_id]
        authorize! :update, form
        
        question = Question::Creator.call(args)
        question.rearrange(question.order)

        test = Question.new(args)

        if test.valid?(:question_without_form)
          if question.save
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