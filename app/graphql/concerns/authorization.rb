module Authorization 
  def authorize!(action, resource)
      user = context[:current_user]
      Ability.new(user).authorize!(action, resource)
      
  end
end

