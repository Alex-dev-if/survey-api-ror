module Types
  module Arguments
      class CreateQuestionsWithForm < BaseInputObject
        
        argument :title, String, required: true
        argument :question_type, String, required: false, default_value: "text"
        argument :required, Boolean, required: false, default_value: false
        argument :options, [String], required: false
        argument :order, Integer, required: true

      end
  end
end

