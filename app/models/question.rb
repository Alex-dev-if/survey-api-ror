class Question < ApplicationRecord

  belongs_to :form
  has_many :answers, dependent: :delete_all

  enum question_type: %i[text radio checkbox]

  validates :options, absence: true, unless: :options_required?
  validates :options, presence: true, length: { maximum: 5 }, if: :options_required?
  validate :order_validation, on: [:question_without_form, :update]
  validate :permit_create, on: :question_without_form


  def permit_create
    errors.add(:base, "maximum limit of ten questions per form") if form.questions_quantity >= 10
  end

  def options_required?
    question_type != "text"
  end

  def order_validation
    if new_record?
      if order > form.questions_quantity+1
        errors.add(:order, "must be less than or equal to #{form.questions_quantity+1}")
      end
    elsif order > form.questions_quantity
      errors.add(:order, "must be less than or equal to #{form.questions_quantity}")
    end
  end
    
  def rearrange
    return unless saved_change_to_order?

    if previously_new_record?
      return if order == form.questions_quantity
      form.questions.where('"order" >= ?', order).where.not(id: id).update_all('"order" = "order" + 1')
    else
      previous_order = saved_change_to_order[0]
      if previous_order > order
        form.questions.where(order: order...previous_order).where.not(id: id).update_all('"order" = "order" + 1')
      elsif previous_order < order
        form.questions.where('"order" between ? and ?', previous_order, order).where.not(id: id).update_all('"order" = "order" - 1')
      end
    end
  end
end
