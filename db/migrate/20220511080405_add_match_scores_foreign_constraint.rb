class AddMatchScoresForeignConstraint < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :scores, :matches
  end
end
