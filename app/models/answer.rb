class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  
  validates :content, length: {maximum: :options_quantity}, unless: :text_type?
  validate :content_type
  validate :permit_create

  def permit_create
    form = Form.find question.form_id
    errors.add(:base, "response time expired") unless form.permit_reply
  end

  def options_quantity
    question.options.size
  end

  def text_type?
    question.question_type == "text"
  end

  def content_type
    if text_type?
      errors.add(:base, "answer must be a string") unless content.is_a? String
    else
      errors.add(:base, "answer must be a array of integers") unless content.is_a?(Array) && content.all? { |element| element.is_a?(Integer) }
      errors.add(:base, "answer not found in question options") unless content.all? {|element| element <= options_quantity}
    end

  end
end
