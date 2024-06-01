class Question::Deleter < ApplicationServices

  def initialize(id)
    @id = id
  end

  def call
    delete_question
  end

  def delete_question
    ActiveRecord::Base.transaction do
      Question.find(@id).destroy!
    end 
  end
end