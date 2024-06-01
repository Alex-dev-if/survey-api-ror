module Mutations
  module Forms
    class DeleteForm < BaseMutation

      argument :id, ID, required: true
      
      field :sucess, Boolean, null: true
      field :errors, [String], null: true

      def resolve(id:)

        authorize! :delete, Form

        form = Form::Deleter.call(id)
        
        if context[:current_user] != form.user
          {errors: ["You aren't authorized because you are not the owner"]} 
        elsif form.destroyed?
          {sucess: true}
        else
          {sucess: false, errors: ["Could not delete"]}
        end
      end
    end
  end
end