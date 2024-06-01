class RenameColumnFormsId < ActiveRecord::Migration[7.0]
  def change
    rename_column :questions, :forms_id, :form_id
  end
end
