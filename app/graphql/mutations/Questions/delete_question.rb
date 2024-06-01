module Mutations
  module Questions
    class DeleteQuestion < BaseMutation

      argument :id, ID, required: true
    
      field :errors, [String], null: true
      field :sucess, Boolean, null: true

      def resolve(id:)


        question = Question.find id

        authorize! :delete, question

        question = Question::Deleter.call(id)

        if question.destroyed?
          {sucess: true}
        else
          {sucess: false, errors: ["Could not delete"]}
        end
        
      end
    end
  end
end