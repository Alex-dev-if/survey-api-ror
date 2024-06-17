require 'rails_helper'
require 'graphql'

RSpec.describe "#CreateUser mutation" do

  let(:user) {build(:user)}

  it "is successful with correct data" do

    result = SurveyApiSchema.execute(query, variables: {
      username: user.username,
      password:  user.password,
      role: user.role
    })
    
    expect(result.dig("data", "createUser", "user", "role")).to eq(user.role)
    expect(result.dig("data", "createUser", "user", "username")).to eq(user.username)
    expect(result.dig("data", "createUser", "success")).to eq(true)
    expect(result.dig("errors")).to be_nil
  end

  it "fails in case of username duplicated" do

    User.create!(user.attributes.to_h)

    result = SurveyApiSchema.execute(query, variables: {
      username: user.username,
      password:  user.password,
      role: user.role
    })

    expect(result.dig("data", "createUser")).to be_nil
    expect(result.dig("errors", 0, "message")).to eq("Username \"#{user.username}\" has already been taken")
  end


  it "fails in case of no password" do

    result = SurveyApiSchema.execute(query, variables: {
      username: user.username,
      password:  "",
      role: user.role
    })

    expect(result.dig("errors", 0, "message")).to include("Password can't be blank")
    expect(result.dig("data", "createUser")).to be_nil
  end

  it "fails in case of invalid role" do

    expect { result = SurveyApiSchema.execute(query, variables: {
      username: user.username,
      password:  user.password,
      role: "invalid_role"
    }) }.to raise_error(ArgumentError, "'invalid_role' is not a valid role")
  end

  def query
    <<~GQL
    mutation CreateUser ($username: String!, $password: String!, $role: String!) {
      createUser(
        input: {
          credentials:{
            username: $username, password: $password, role: $role
          }
        }
      ) {
          user {
              createdAt
              id
              passwordDigest
              role
              updatedAt
              username
          }
          success
      }
  }
  
    GQL
  end
end