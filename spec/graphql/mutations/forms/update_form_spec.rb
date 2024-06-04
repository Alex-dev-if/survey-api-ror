require 'rails_helper'
require 'graphql'


RSpec.describe "#UpdateForm mutation" do
  let(:form) { build(:form) }
  let(:user) { build(:user) }
  it "is successful with correct data" do
    User.create!(user.attributes.to_h)
    Form.create!(form.attributes.to_h)
    title = "diferent title"
    respond_until = 3.days.ago.iso8601
    opened = !form.opened

    result = SurveyApiSchema.execute(query, variables: {
      title: title,
      opened:  opened,
      respond_until: respond_until,
      id: form.id
    },
    context: {current_user: user}
    )

    expect(result.dig("data", "updateForm", "form", "title")).to eq(title)    
    expect(result.dig("data", "updateForm", "form", "opened")).to eq(opened)    
    expect(result.dig("data", "updateForm", "form", "respondUntil")).to eq(respond_until)    
    expect(result.dig("data", "updateForm", "form", "userId")).to eq(user.id)    
    expect(result.dig("data", "updateForm", "form", "id")).to eq(form.id.to_s)    



  end


  def query
    <<~GQL
    mutation UpdateForm ($title: String!, $opened: Boolean!, $respond_until: ISO8601DateTime, $id: ID!){
      updateForm(input: { title: $title, opened: $opened, respondUntil: $respond_until, id: $id }) {
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