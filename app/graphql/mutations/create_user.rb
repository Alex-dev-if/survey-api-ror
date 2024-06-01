module Mutations
  class CreateUser < BaseMutation

  
    argument :credentials, Types::AuthProviderCredentialsInput, required: true

    field :errors, [String], null: true
    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      user = User::Creator.call(credentials)

      if user.save
        {user: user}
      else
        {errors: user.errors.full_messages}      
      end
    end
  end
end