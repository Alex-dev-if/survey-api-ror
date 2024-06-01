module Mutations
  module Forms
    class CreateForm < BaseMutation

      input_object_class Types::Arguments::Form::CreateFormArguments
    
      field :errors, [String], null: true
      field :form, Types::FormType, null: true

      def resolve(args)

        authorize! :create, Form
        args[:user_id] = context[:current_user].id

        form = Form::Creator.call(args)

        if form.save
          {form: form}
        else
          {errors: form.errors.full_messages}      
        end
      end
    end
  end
end