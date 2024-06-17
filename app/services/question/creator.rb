class Question::Creator < ApplicationServices

  def initialize(arguments)
    @arguments = arguments
  end

  def call
    question = create_question

    if question.save(context: :question_without_form)
      # rearranjando a order 
      question.rearrange
      {question: question}
    else
      raise GraphQL::ExecutionError, question.errors.full_messages.join(", ")
    end

  end

  def create_question
    ActiveRecord::Base.transaction do
      question = Question.new(@arguments)
    end 
  end
end