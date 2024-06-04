class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true

  validates :content, length: {is: 1, message: "can only have one option to be checked"}, if: :radio_type?
  validates :content, length: {maximum: :options_quantity, too_long: "Content is too long (maximum is 2 options)"}, unless: [:text_type?, :radio_type?] 

  validate :content_type
  validate :no_repeat, unless: [:text_type?, :radio_type?] 
  validate :permit_create

  def no_repeat
    return if content.is_a?(String)
    errors.add(:content, "with repeated options") if content.size != content.uniq.size
  end

  def permit_create
    form = Form.find question.form_id
    errors.add(:base, "response time expired") unless form.permit_reply
  end

  def options_quantity
    question.options.size
  end

  def radio_type?
    question.radio?
  end

  def text_type?
    question.text?
  end

  def content_type
    if text_type?
      errors.add(:base, "answer must be a string") unless content.is_a? String
    else
      if content.is_a?(Array) 
        if content.any? { |element| !element.is_a?(Integer) }
          errors.add(:base, "answer must be a array of integers")
        else
          errors.add(:base, "answer not found in question options") unless content.all? {|element| element <= options_quantity}
        end
      else
        errors.add(:base, "answer must be a array")
      end
    end
  end

end
