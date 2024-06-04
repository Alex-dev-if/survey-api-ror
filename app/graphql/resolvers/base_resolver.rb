module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    include Authorization
    
    def auth(action, object, id=nil)
      if object == Question
        authorize! :manage, Question
        form = Form.find(Question.find(id).form_id)
        authorize! :manage, form
      else
        authorize! action, object
      end
    end

  end
end
