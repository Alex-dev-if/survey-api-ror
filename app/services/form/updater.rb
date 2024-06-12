class Form::Updater < ApplicationServices

  def initialize(args)
    @args = args
  end

  def call
    form = find_form

    if form.update!(@args)
      {form: form}
    else
      raise GraphQL::ExecutionError, form.errors.full_messages.join(", ")
    end
    
  end

  def find_form
    form = Form.find @args[:id]
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, e
  end
end