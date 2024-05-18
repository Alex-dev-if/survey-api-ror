module Mutations
  class SignInUser < BaseMutation

    graphql_name "signInUser"

    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, String, null: true

    def resolve(credentials: nil)
      return unless credentials
      
      user = User.find_by username: credentials[:username]
      return {errors: 'username or password is incorrect'} unless user.authenticate(credentials[:password])

      token = JsonWebToken.encode_token({user_id: user.id, role: user.role})
      { user: user, token: token, errors: ''}
    end
  end
end