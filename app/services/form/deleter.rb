class Form::Deleter < ApplicationServices

  def initialize(id)
    @id = id
  end

  def call
    form = delete_form

    if form.destroyed?
      {form: form}
      {success: true}
    else
      {success: false}
    end
  end

  def delete_form
    form = Form.find(@id).destroy!
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, e
  end
end