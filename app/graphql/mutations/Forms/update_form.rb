module Mutations
  module Forms
    class UpdateForm < BaseMutation
      
      input_object_class Types::Arguments::Form::UpdateFormArguments
    
      field :errors, [String], null: true
      field :form, Types::FormType, null: true

      def resolve(args)

        authorize! :update, Form

        form = Form.find args[:id]

        form = Form::Updater.call(args)

        if context[:current_user] != form.user
          {errors: ["You aren't authorized because you are not the owner"]} 
        elsif form.update!(args)
          {form: form}
        else
          {errors: form.errors.full_messages}      
        end
      end
    end
  end
end