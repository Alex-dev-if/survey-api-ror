class Form < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :delete_all
  has_many :answers, dependent: :delete_all

  include Opened

  def permit_reply
    return true if respond_until.nil?
    return false if DateTime.current > respond_until
    true
  end

  def questions_quantity
    questions.size
  end
end
