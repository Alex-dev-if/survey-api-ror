require 'rails_helper'
require 'graphql'


RSpec.describe "#DeleteForm mutation" do
  let(:form) { build(:form) }
  let(:user) { build(:user) }
  it "is successful with correct data" do
    User.create!(user.attributes.to_h)
    Form.create!(form.attributes.to_h)
    result = SurveyApiSchema.execute(query, variables: {
      id: form.id
    },
    context: {current_user: user}
    )

    expect(result.dig("data", "deleteForm", "success")).to eq(true)     

  end


  def query
    <<~GQL
    mutation DeleteForm ($id: ID!) {
        deleteForm(input: { id: $id }) {
            success
        }
    }

    GQL
  end
end