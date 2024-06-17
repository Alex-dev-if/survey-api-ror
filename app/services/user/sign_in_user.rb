class User::SignInUser < ApplicationServices

  def initialize(username, password)
    @username = username
    @password = password
  end

  def call
    sign_in

    {user: @user, token: @token}
  end
  
  def sign_in
    @user = User.find_by! username: @username

      if @user.authenticate(@password)
        @token = JsonWebToken.encode_token({user_id: @user.id})
      else
        raise GraphQL::ExecutionError, 'incorrect password'
      end
    
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, "couldn't find user with username \"#{@username}\""
  end
end