class ChangeAnswersUserIdColumn < ActiveRecord::Migration[7.0]
  def change
    remove_reference :answers, :user, foreign_key: true, null: false
    add_reference :answers, :user, foreign_key: true

  end
end
