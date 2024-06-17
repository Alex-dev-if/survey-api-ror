class Form::Creator < ApplicationServices

  def initialize(arguments)
    @arguments = arguments
  end

  def call
    create_form
  end

  def create_form
    ActiveRecord::Base.transaction do
      form = Form.create!(@arguments)
    end 
  end
end