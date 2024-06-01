class Question < ApplicationRecord

  belongs_to :form
  has_many :answers, dependent: :delete_all

  enum question_type: %i[text radio checkbox]

  validates :options, absence: true, unless: :options_required?
  validates :options, presence: true, length: { maximum: 5 }, if: :options_required?
  validate :order_validation, on: :question_without_form
  validate :permit_create
  
  def permit_create
    errors.add(:base, "maximum limit of ten questions per form") if form.questions_quantity > 10
  end

  
  def options_required?
    question_type != "text"
  end

  def order_validation
    if order > form.questions.count + 1
      errors.add(:order, "must be less than or equal to #{form.questions_quantity+1}")
    end
  end
    
  def rearrange(new_order)
    return if new_order == form.questions_quantity
    form.questions.each do |question|
      if question.order >= new_order && question != self
        question.order += 1
        question.save
      end
    end
  end
end
