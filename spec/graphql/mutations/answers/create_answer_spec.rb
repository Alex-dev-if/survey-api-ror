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
      user_id: answer.user_id,
      question_id: answer.question_id
    },
    context: {current_user: user}
    )

    expect(result.dig("data", "createAnswer", "answer", "content")).to eq(answer.content)    
    expect(result.dig("data", "createAnswer", "answer", "userId")).to eq(answer.user_id)    
    expect(result.dig("data", "createAnswer", "answer", "questionId")).to eq(answer.question_id)    

  end


  def query
    <<~GQL
    mutation CreateAnswer ($content: JSON!, $question_id: Int!){
      createAnswer(input: { content: $content, questionId: $question_id}) {
          answer {
            content
            createdAt
            id
            questionId
            updatedAt
            userId
        }
      }
  }  
    GQL
  end
end