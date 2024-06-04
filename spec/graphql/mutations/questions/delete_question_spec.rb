require 'rails_helper'
require 'graphql'


RSpec.describe "#CreateQuestion mutation" do
  let(:form) { build(:form) }
  let(:user) { build(:user) }
  let(:question) { build(:question) }
  it "is successful with correct data" do
    User.create!(user.attributes.to_h)
    Form.create!(form.attributes.to_h)
    Question.create!(question.attributes.to_h)
    result = SurveyApiSchema.execute(query, variables: {
      id: 1
    },
    context: {current_user: user}
    )

    expect(result.dig("data", "deleteQuestion", "success")).to eq(true)    
  end 

  
  def query
    <<~GQL
    mutation DeleteQuestion ($id: ID!) {
      deleteQuestion(input: { id: $id }) {
          success
      }
  }
  
    GQL
  end
end