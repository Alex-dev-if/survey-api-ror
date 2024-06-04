require 'rails_helper'
require 'graphql'


RSpec.describe "#UpdateQuestion mutation" do
  let(:form) { build(:form) }
  let(:user) { build(:user) }
  let(:question) { build(:question) }
  it "is successful with correct data" do
    User.create!(user.attributes.to_h)
    Form.create!(form.attributes.to_h)
    Question.create!(question.attributes.to_h)
    title = "diferent title"
    options = ["diferent", "options"]
    question_type = "checkbox"
    required = !question.required

    result = SurveyApiSchema.execute(query, variables: {
      title: title,
      id:  1,
      options: options,
      question_type: question_type,
      required: required
    },
    context: {current_user: user}
    )

    expect(result.dig("data", "updateQuestion", "question", "title")).to eq(title)    
    expect(result.dig("data", "updateQuestion", "question", "required")).to eq(required)    
    expect(result.dig("data", "updateQuestion", "question", "options")).to eq(options)    
    expect(result.dig("data", "updateQuestion", "question", "questionType")).to eq(question_type)    
  end

  
  def query
    <<~GQL
    mutation UpdateQuestion ($title: String!, $required: Boolean!, $id: ID!, $options: [String!], $question_type: String! ) {
      updateQuestion(input: { title: $title, id: $id, required: $required, questionType: $question_type, options: $options }) {
          question {
              createdAt
              formId
              id
              options
              order
              questionType
              required
              title
              updatedAt
          }
      }
  }  
    GQL
  end
end