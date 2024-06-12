class User::Creator < ApplicationServices

  def initialize(args)
    @args = args.to_hash
  end

  def call
    user = create_user

    if user.save
      {user: user}
    else
      raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
    end
  end
  
  def create_user
    user = User.new(@args)
  end
end