class AddNonNullConstraintToHandicap < ActiveRecord::Migration[7.0]
  def change
    change_column :players, :handicap, :numeric, null: false
  end
end
