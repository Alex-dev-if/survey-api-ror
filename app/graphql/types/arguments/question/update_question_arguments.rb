module Types
  module Arguments
    module Question
      class UpdateQuestionArguments < BaseInputObject
        
        argument :title, String, required: false
        argument :question_type, Integer, required: false
        argument :required, Boolean, required: false, default_value: false
        argument :options, [String], required: false
        argument :id, ID, required: true
        
      end
    end
  end
end