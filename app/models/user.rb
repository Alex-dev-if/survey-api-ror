class User < ApplicationRecord
  has_secure_password
  has_many :forms, dependent: :delete_all
  has_many :answers, dependent: :delete_all

  validates :username, presence: true, uniqueness: {message: '"%{value}" has already been taken'}

  enum role: %i[user adm]
  
end
  