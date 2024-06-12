class Question::Updater < ApplicationServices

  def initialize(args)
    @args = args
  end

  def call
    question = find_question

    if question.update!(@args)
      question.rearrange
      {question: question}
    else
      raise GraphQL::ExecutionError, question.errors.full_messages.join(", ")
    end

  end

  def find_question
    question = Question.find @args[:id]
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, e
  end
end