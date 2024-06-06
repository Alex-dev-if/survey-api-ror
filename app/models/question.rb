class Question < ApplicationRecord

  belongs_to :form
  has_many :answers, dependent: :delete_all
  self.implicit_order_column = "order"

  enum question_type: %i[text radio checkbox]

  validates :options, absence: true, if: -> {self.text?}
  validates :options, presence: true, length: { maximum: 5 }, if: -> {!self.text?}

  validate :order_validation, on: [:question_without_form, :update]
  validate :permit_create, on: :question_without_form

  def order_validation
    if new_record?
      if order > form.questions_quantity+1 #verificando se a ordem não é maior que o número de questões do form
        errors.add(:order, "must be less than or equal to #{form.questions_quantity+1}")
      end
    elsif order > form.questions_quantity
      errors.add(:order, "must be less than or equal to #{form.questions_quantity}")
    end
  end

  def permit_create
    errors.add(:base, "maximum limit of ten questions per form") if form.questions_quantity >= 10
  end
  
  def rearrange #rearranjando a ordem quando o user cria ou atualiza uma questão (exceto se cria junto com o formulário)
    
    if previously_new_record?
      create_rearrange
    elsif saved_change_to_order?
      update_rearrange
    elsif destroyed?
      delete_rearrange
    end
  end

  def create_rearrange 
    return unless order != form.questions_quantity
    form.questions.where('"order" >= ?', order).where.not(id: id).update_all('"order" = "order" + 1') #rearrajando
  end

  def update_rearrange
    previous_order = saved_change_to_order[0]
    if previous_order > order # se a ordem diminuiu: aumente em um de order até previous_order
      form.questions.where(order: order...previous_order).where.not(id: id).update_all('"order" = "order" + 1')
    elsif previous_order < order # caso inverso
      form.questions.where('"order" between ? and ?', previous_order, order).where.not(id: id).update_all('"order" = "order" - 1')
    end
  end

  def delete_rearrange
    return unless order != form.questions_quantity
    form.questions.where('"order" >= ?', order).update_all('"order" = "order" - 1') 
  end

end
