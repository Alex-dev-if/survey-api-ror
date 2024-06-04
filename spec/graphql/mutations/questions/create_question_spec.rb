require 'rails_helper'
require 'graphql'


RSpec.describe "#CreateQuestion mutation" do
  let(:form) { build(:form) }
  let(:user) { build(:user) }
  let(:question) { build(:question) }
  
  it "is successful with correct data" do
    User.create!(user.attributes.to_h)
    Form.create!(form.attributes.to_h)
    result = SurveyApiSchema.execute(query, variables: {
      title: question.title,
      form_id:  form.id,
      options: question.options,
      order: question.order,
      question_type: question.question_type,
      required: question.required
    },
    context: {current_user: user}
    )

    expect(result.dig("data", "createQuestion", "question", "title")).to eq(question.title)    
    expect(result.dig("data", "createQuestion", "question", "required")).to eq(question.required)    
    expect(result.dig("data", "createQuestion", "question", "formId")).to eq(question.form_id)    
    expect(result.dig("data", "createQuestion", "question", "options")).to eq(question.options)    
    expect(result.dig("data", "createQuestion", "question", "order")).to eq(question.order)    
    expect(result.dig("data", "createQuestion", "question", "questionType")).to eq(question.question_type)    
  end

  
  def query
    <<~GQL
    mutation CreateQuestion ($title: String!, $required: Boolean!, $form_id: ID!, $options: [String!], $order: Int!, $question_type: String! ) {
      createQuestion(input: { title: $title, order: $order, formId: $form_id, required: $required, questionType: $question_type, options: $options }) {
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