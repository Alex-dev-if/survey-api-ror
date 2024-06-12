class CreateFormAndQuestionsService < ApplicationServices

  def initialize(form, questions)
    @form = form
    @questions = questions
    @errors = []
      
  end

  def call
    form_instance
    questions_instances
    create_form_and_questions

    if @errors.blank?
      {form: @form, questions: @questions}
    else
      puts @errors
      {errors: @errors}
    end
  end

  def form_instance
    @form = Form.new(@form)
    @form.valid?

    unless @questions.count <= 10
      @form.errors.add(:questions, "quantity must be less than or equal to 10")
    end

    if @form.errors.any?
      error = @form.errors.full_messages.join(", ")
      @errors << "formulary: #{error}"
    end
  end
  
  def questions_instances
    @questions.each_with_index do |question, idx|
      question = Question.new(question.to_h)
      @questions[idx] = question
      question.valid?

      unless question.order <= @questions.count
        question.errors.add(:base, "order greather than number of questions")
      end

      question.errors.delete(:form, :blank)
      
      if question.errors.any?
        error = question.errors.full_messages.join(", ")
        @errors << "question #{idx+1}: #{error}"
      end
    end
  end

  def create_form_and_questions
    if @errors.blank? 
      ActiveRecord::Base.transaction do
        @form.save!
        @questions.each do |question|
          question.form_id = @form.id
          question.save!
        end
      end
    end
  end

end