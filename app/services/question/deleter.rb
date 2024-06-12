class Question::Deleter < ApplicationServices

  def initialize(id)
    @id = id
  end

  def call
    question = delete_question

    if question.destroyed?
      question.rearrange
      {success: true}
    else
      {success: false}
    end
  end

  def delete_question
    question = Question.find(@id).destroy!
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, e
  end
end