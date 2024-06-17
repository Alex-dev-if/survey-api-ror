require 'rails_helper'
require 'graphql'


RSpec.describe "#DeleteForm mutation" do
  let(:form) { build(:form) }
  let(:user) { build(:user) }
  it "is successful with correct data" do
    User.create!(user.attributes.to_h)
    Form.create!(form.attributes.to_h)
    form = Form.create!(form.attributes.to_h.merge(user_id: user.id))
    result = SurveyApiSchema.execute(query, variables: {
      id: form.id
    },
    context: {current_user: user}
    )

    expect(result.dig("data", "createForm", "success")).to eq(true)     


  end


  def query
    <<~GQL
    mutation CreateForm ($title: String!, $opened: Boolean!, $respond_until: ISO8601DateTime){
      createForm(input: { title: $title, opened: $opened, respondUntil: $respond_until}) {
          form {
              createdAt
              id
              title
              updatedAt
              userId
              opened
              respondUntil
          }
      }
  }  
    GQL
  end
end