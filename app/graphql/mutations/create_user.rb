module Mutations
  class CreateUser < BaseMutation

  
    argument :credentials, Types::AuthProviderCredentialsInput, required: true

    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      User::Creator.call(credentials)
    end
  end
end