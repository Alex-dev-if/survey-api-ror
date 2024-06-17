class Question::Creator < ApplicationServices

  def initialize(args)
    @args = args
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
    question = Question.new(@args)
  end
end