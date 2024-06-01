class Answer::Creator < ApplicationServices

  def initialize(arguments)
    @arguments = arguments
  end

  def call
    create_answer
  end

  def create_answer
    ActiveRecord::Base.transaction do
      answer = Answer.create!(@arguments)
    end 
  end
end