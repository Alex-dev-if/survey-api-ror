module Types
  module Arguments
    module Question
      class UpdateQuestionArguments < BaseInputObject
        
        argument :title, String, required: false
        argument :question_type, String, required: false
        argument :required, Boolean, required: false, default_value: false
        argument :options, [String], required: false
        argument :id, ID, required: true
        argument :order, Integer, required: false
        
      end
    end
  end
end