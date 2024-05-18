module Mutations
  class CreateUser < BaseMutation
    graphql_name "CreateUser"

  
    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    field :errors, [String], null: true
    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      @user = User::Creator.call(credentials)

      if @user.save
        {user: @user}
      else
        {errors: @user.errors}      
      end
    end
  end
end