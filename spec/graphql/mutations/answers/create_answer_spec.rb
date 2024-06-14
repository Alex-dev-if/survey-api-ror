require 'rails_helper'
require 'graphql'


RSpec.describe "#CreateAnswer mutation" do
  let(:answer) { build(:answer) }
  let(:question) { build(:question) }
  let(:user) { build(:user) }
  let(:form) { build(:form) }

  it "is successful with correct data" do
    User.create!(user.attributes.to_h)
    Form.create!(form.attributes.to_h)
    Question.create!(question.attributes.to_h)

    result = SurveyApiSchema.execute(query, variables: {
      content: answer.content,
      question_id: answer.question_id,
      form_id: answer.form_id
    },
    context: {current_user: user}
    )

    expect(result.dig("data", "createAnswer", "answers", 0, "content")).to eq(answer.content)    
    expect(result.dig("data", "createAnswer", "answers", 0, "userId")).to eq(answer.user_id)    
    expect(result.dig("data", "createAnswer", "answers", 0, "questionId")).to eq(answer.question_id)
    expect(result.dig("data", "createAnswer", "answers", 0, "formId")).to eq(answer.form_id)
    expect(result.dig("data", "createAnswer", "errors")).to be_nil
  end


  def query
    <<~GQL
    mutation CreateAnswer ($content: JSON!, $question_id: Int!, $form_id: ID!){
      createAnswer(input: { formId: $form_id
        answers: [
          {content: $content, questionId: $question_id}
        ]}) {
            errors
            answers {
              content
              createdAt
              id
              questionId
              updatedAt
              userId
              formId
          }
      }
  }  
    GQL
  end
end