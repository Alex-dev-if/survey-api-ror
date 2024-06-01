class User::Creator < ApplicationServices

  def initialize(arguments)
    @arguments = arguments.to_hash
  end

  def call
    create_user
  end
  
  def create_user
    ActiveRecord::Base.transaction do
      user = User.new(@arguments)
    end 
  end
end