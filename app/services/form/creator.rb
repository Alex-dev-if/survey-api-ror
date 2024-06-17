class Form::Creator < ApplicationServices

  def initialize(args)
    @args = args
  end

  def call
    form = create_form

    if form.save
      {form: form}
    else
      raise GraphQL::ExecutionError, form.errors.full_messages.join(", ")
    end
  end

  def create_form
    form = Form.new(@args)
  end
end