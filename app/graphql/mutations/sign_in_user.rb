module Mutations
  class SignInUser < BaseMutation


    argument :credentials, Types::AuthProviderCredentialsInput, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      return unless credentials

      user = User.find_by username: credentials[:username]

      if user.present? && user.authenticate(credentials[:password])
        token = JsonWebToken.encode_token({user_id: user.id})
        {user: user, token: token}
      else
        raise GraphQL::ExecutionError, 'username or password is incorrect'
      end
    end
  end
end