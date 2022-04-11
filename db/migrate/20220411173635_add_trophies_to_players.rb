class AddTrophiesToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :trophies, :string
  end
end
