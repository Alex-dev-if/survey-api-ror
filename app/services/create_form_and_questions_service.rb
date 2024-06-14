class CreateFormAndQuestionsService < ApplicationServices

  def initialize(form, questions)
    @form = form
    @questions = questions
    @errors = []
      
  end

  def call
    #criando instâncias e salvando se não tiver nenhum erro antes
    form_instance
    questions_instances
    create_form_and_questions

    if @errors.blank?
      {form: @form, questions: @questions}
    else
      {errors: @errors}
    end
  end

  def form_instance
    @form = Form.new(@form)
    # criando erros de validação se houverem 
    @form.valid?

    unless @questions.count <= 10
      @form.errors.add(:questions, "quantity must be less than or equal to 10")
    end

    # adicionando erros ao array de erros
    if @form.errors.any?
      error = @form.errors.full_messages.join(", ")
      @errors << "formulary: #{error}"
    end
  end
  
  def questions_instances
    if @errors.blank? 
      # Se o formulário não possuir erros execute:
      @questions.each_with_index do |question, idx|
        # order de acordo com a sequencia de questões mandada
        question = Question.new(question.to_h.merge(order: idx+1))
        @questions[idx] = question
        
        question.valid?

        # deletando erro de form não declarado, já que o form será adicionado posteriormente
        question.errors.delete(:form, :blank)
        
        if question.errors.any?
          error = question.errors.full_messages.join(", ")
          @errors << "question #{idx+1}: #{error}"
        end
      end
    end
  end

  def create_form_and_questions
    if @errors.blank? 
      ActiveRecord::Base.transaction do
        @form.save!
        @questions.each do |question|
          # declando o form das questões
          question.form_id = @form.id
          question.save!
        end
      end
    end
  end
end