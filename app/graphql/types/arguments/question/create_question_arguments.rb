module Types
  module Arguments
    module Question
      class CreateQuestionArguments < BaseInputObject
        
        argument :title, String, required: true
        argument :question_type, String, required: false, default_value: "text"
        argument :required, Boolean, required: false, default_value: false
        argument :options, [String], required: false
        argument :form_id, ID, required: true
        argument :order, Integer, required: true

      end
    end
  end
end