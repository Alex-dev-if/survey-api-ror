class Question < ApplicationRecord

  belongs_to :form
  has_many :answers, dependent: :delete_all
  self.implicit_order_column = "order"

  enum question_type: %i[text radio checkbox]

  validates :options, absence: true, if: -> {self.text?}
  validates :options, presence: true, length: { maximum: 5 }, if: -> {!self.text?}

  validate :order_validation, on: [:question_without_form, :update]
  validate :permit_create, on: :question_without_form

  include Rearrange

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
  
  
end
