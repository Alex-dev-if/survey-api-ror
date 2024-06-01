class Form < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :delete_all

  def permit_reply
    if respond_until.nil?
      true
    elsif DateTime.current > respond_until
      false
    else
      true
    end
  end

  def questions_quantity
    questions.size
  end
end
