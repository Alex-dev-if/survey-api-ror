class Question::Creator < ApplicationServices

  def initialize(arguments)
    @arguments = arguments
  end

  def call
    create_question
  end

  def create_question
    ActiveRecord::Base.transaction do
      question = Question.new(@arguments)
    end 
  end
end