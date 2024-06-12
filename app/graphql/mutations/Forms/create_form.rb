module Mutations
  module Forms
    class CreateForm < BaseMutation

      input_object_class Types::Arguments::Form::CreateFormArguments
    
      field :form, Types::FormType, null: true

      def resolve(args)

        auth(:create, Form)
        
        args[:user_id] = context[:current_user].id

        Form::Creator.call(args)

      end
    end
  end
end