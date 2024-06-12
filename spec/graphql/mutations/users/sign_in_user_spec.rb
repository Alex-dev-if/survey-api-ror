require 'rails_helper'
require 'graphql'

RSpec.describe "#SignInUser mutation" do
  let(:user) { build(:user) }

  def create_user
    User.create!(username: user.username, password: user.password)
  end

  it "is successful with correct data" do

    create_user
    result = SurveyApiSchema.execute(query, variables: {
      username: user.username,
      password:  user.password
    })
    
    expect(result.dig("data", "signInUser", "token")).not_to be_nil
    expect(result.dig("data", "signInUser", "user", "username")).to eq(user.username)
  end

  it "fails in case of user not found" do

    create_user
    username = "not_found_username"

    result = SurveyApiSchema.execute(query, variables: {
      username: username,
      password: user.password
    })

    expect(result.dig("errors", 0, "message")).to include("couldn't find user with username \"#{username}\"")
    expect(result.dig("data", "signInUser")).to be_nil
  end

  it "fails in case of incorrect password" do
    
    create_user
    result = SurveyApiSchema.execute(query, variables: {
      username: user.username,
      password:  "incorrect_password"
    })

    expect(result.dig("errors", 0, "message")).to include("incorrect password")
    expect(result.dig("data", "signInUser")).to be_nil
  end

  def query
    <<~GQL
    mutation SignInUser ($username: String!, $password: String!) {
      signInUser(input: { credentials: { username: $username, password: $password } }) {    
          token
          user {
              createdAt
              id
              passwordDigest
              role
              updatedAt
              username
          }
      }
  }
  
    GQL
  end
end