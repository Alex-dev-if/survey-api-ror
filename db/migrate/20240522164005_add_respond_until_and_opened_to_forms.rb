class AddRespondUntilAndOpenedToForms < ActiveRecord::Migration[7.0]
  def change
    add_column :forms, :respond_until, :datetime
    add_column :forms, :opened, :boolean
  end
end
