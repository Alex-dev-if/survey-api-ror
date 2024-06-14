# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include Authorization

    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    field :success, Boolean

    def auth(action, object, id=nil)
      if object == Question
        authorize! action, object
        # É passado o id do form ou da questão a depender do contexto da mutations
        form = action == :create ? Form.find(id) : Form.find(Question.find(id).form_id)
        authorize! :update, form
      else
        authorize! action, object
      end
    end
  end
end
