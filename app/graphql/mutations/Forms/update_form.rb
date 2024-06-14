module Mutations
  module Forms
    class UpdateForm < BaseMutation
      
      input_object_class Types::Arguments::Form::UpdateFormArguments
    
      field :form, Types::FormType, null: true

      def resolve(args)
        form = Form.find args[:id]
        auth(:update, form)

        Form::Updater.call(args)
      end
    end
  end
end