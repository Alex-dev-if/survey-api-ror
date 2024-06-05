class Answer::Creator < ApplicationServices

  def initialize(arguments, user_id=nil)
    @answers = arguments[:answers].map do |answer|
      answer = answer.to_h.merge(user_id: user_id)
    end
    
  end

  def call
    create_answer
  end

  def create_answer
    answers = []
    ActiveRecord::Base.transaction do
      @answers.map do |answer|
        answers << answer = Answer.new(answer)
      end
    end
    answers
  end
end