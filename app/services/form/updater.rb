class Form::Updater < ApplicationServices

  def initialize(arguments)
    @arguments = arguments
  end

  def call
    update_form
  end

  def update_form
    ActiveRecord::Base.transaction do
      form = Form.find @arguments[:id]
      form.update!(@arguments)
      form
    end 
  end
end