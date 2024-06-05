class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true


  validates :content, length: {in: 0..1, message: "can only have one option to be checked"}, if: -> {question.radio? && content.is_a?(Array)}
  validates :content, length: {maximum: :options_quantity, too_long: "Content is too long (maximum is %{count} options)"}, if: -> {question.checkbox? && content.is_a?(Array)}

  validate :no_repeat, if: -> {content.is_a?(Array) && question.checkbox?}
  validate :permit_create
  validate :content_type


  def no_repeat
    errors.add(:content, "with repeated options") if content.size != content.uniq.size
  end

  def permit_create
    form = Form.find question.form_id
    errors.add(:base, "response time expired") unless form.permit_reply
  end

  def content_type
    if question.text?
      validate_text_content
    else
      validate_array_content
    end
  end

  def validate_text_content
    unless content.is_a?(String)
      errors.add(:base, "answer must be a string")
    end
  end

  def validate_array_content
    if !content.is_a?(Array)
      errors.add(:base, "answer must be an array")
    elsif content.any? { |element| !element.is_a?(Integer) }
      errors.add(:base, "answer must be an array of integers")
    elsif content.any? { |element| element > options_quantity || !element.positive? }
      errors.add(:base, "answer not found in question options")
    end
  end

  def options_quantity
    question.options.size
  end
end
