module Mutations
  module Forms
    class CreateForm < BaseMutation

      input_object_class Types::Arguments::Form::CreateFormArguments
    
      field :form, Types::FormType, null: true

      def resolve(args)

        auth(:create, Form)
        
        args[:user_id] = context[:current_user].id

        form = Form::Creator.call(args)

        if form.save
          {form: form}
        else
          raise GraphQL::ExecutionError, form.errors.full_messages.join(", ")
        end
      end
    end
  end
end