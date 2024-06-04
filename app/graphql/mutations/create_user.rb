module Mutations
  class CreateUser < BaseMutation

  
    argument :credentials, Types::AuthProviderCredentialsInput, required: true

    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      user = User::Creator.call(credentials)
      if user.save
        {user: user, success: true}
      else
        raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
      end
    end
  end
end