module Mutations
  module Forms
    class DeleteForm < BaseMutation

      argument :id, ID, required: true
      
      def resolve(id:)
        
        form = Form.find id

        auth(:delete, form)

        Form::Deleter.call(form.id)
        
      end
    end
  end
end