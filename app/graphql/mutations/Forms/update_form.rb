module Mutations
  module Forms
    class UpdateForm < BaseMutation
      
      input_object_class Types::Arguments::Form::UpdateFormArguments
    
      field :form, Types::FormType, null: true

      def resolve(args)

        form = Form.find args[:id]
        auth(:update, form)

        form = Form::Updater.call(args)


        if form.update!(args)
          {form: form}
        else
          raise GraphQL::ExecutionError, form.errors.full_messages.join(", ")
        end
      end
    end
  end
end