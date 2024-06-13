class AddFormIdToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_reference :answers, :form, foreign_key: true, null: false
  end
end
