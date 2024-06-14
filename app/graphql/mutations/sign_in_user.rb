module Mutations
  class SignInUser < BaseMutation


    argument :credentials, Types::AuthProviderCredentialsInput, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(credentials:)
      User::SignInUser.call(credentials[:username], credentials[:password])
    end
  end
end