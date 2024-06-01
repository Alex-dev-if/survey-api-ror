class Question::Updater < ApplicationServices

  def initialize(arguments)
    @arguments = arguments
  end

  def call
    update_question
  end

  def update_question
    ActiveRecord::Base.transaction do
      question = Question.find @arguments[:id]
      question.update!(@arguments)
    end 
  end
end