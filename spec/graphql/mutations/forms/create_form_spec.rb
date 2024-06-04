require 'rails_helper'
require 'graphql'


RSpec.describe "#CreateForm mutation" do
  let(:form) { build(:form) }
  let(:user) { build(:user) }
  it "is successful with correct data" do
    User.create!(user.attributes.to_h)
    result = SurveyApiSchema.execute(query, variables: {
      title: form.title,
      opened:  form.opened,
      respond_until: form.respond_until.iso8601,
    },
    context: {current_user: user}
    )

    expect(result.dig("data", "createForm", "form", "title")).to eq(form.title)    
    expect(result.dig("data", "createForm", "form", "opened")).to eq(form.opened)    
    expect(result.dig("data", "createForm", "form", "respondUntil")).to eq(form.respond_until.iso8601)    
    expect(result.dig("data", "createForm", "form", "userId")).to eq(user.id)    


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