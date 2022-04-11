class AddHomeClubToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :home_club, :string
  end
end
