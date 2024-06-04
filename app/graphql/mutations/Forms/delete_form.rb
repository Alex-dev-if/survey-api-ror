module Mutations
  module Forms
    class DeleteForm < BaseMutation

      argument :id, ID, required: true
      
      def resolve(id:)

        form = Form::Deleter.call(id)
        auth(:delete, form)
        
        if form.destroyed?
          {success: true}
        else
          raise GraphQL::ExecutionError, form.errors.full_messages.join(", ")
        end
      end
    end
  end
end