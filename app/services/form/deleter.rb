class Form::Deleter < ApplicationServices

  def initialize(id)
    @id = id
  end

  def call
    delete_form
  end

  def delete_form
    ActiveRecord::Base.transaction do
      Form.find(@id).destroy!
    end 
  end
end