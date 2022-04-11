class AddBestMomentToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :best_moment, :text
  end
end
