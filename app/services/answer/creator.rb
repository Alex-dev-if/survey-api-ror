class Answer::Creator < ApplicationServices

  def initialize(args)

    @form = Form.find(args[:form_id])
    user_id = args[:user_id]
    @answers = args[:answers].map do |answer|
      answer = answer.to_h.merge(user_id: user_id, form_id: @form.id)
    end
    @errors = []

  rescue ActiveRecord::RecordNotFound => e
    raise GraphQL::ExecutionError, e
  end

  def call
    create_answer

    if @errors.blank?
      {answers: @answers}
    else
      {errors: @errors}
    end

  end

  def create_answer 
    required_questions = @form.questions.where(required: true).to_a

    @answers.each_with_index do |answer, idx|
      answer = Answer.new(answer)
      @answers[idx] = answer

      if required_questions.include?(answer.question)
        required_questions -= [answer.question]
      end

      answer.valid?

      unless @form.questions.exists?(id: answer.question_id)
        answer.errors.add(:base, "question not found on form")
      end

      if answer.errors.any?
        error = answer.errors.full_messages.join(", ")
        @errors << "answer #{idx+1}: #{error}"
      end
    end


    if required_questions.any? 
      required_questions.each do |question|
        @errors << "question #{question.order} needs to be answered"
      end
    end
    
    if @errors.blank? 
      ActiveRecord::Base.transaction do
        @answers.each(&:save!)
      end
    end
    
  rescue ActiveRecord::RecordNotFound => e
    raise GraphQL::ExecutionError, e
  end
end