class DropMatchPlayers < ActiveRecord::Migration[7.0]
  def up
    execute "DROP TABLE match_players CASCADE"
  end

  def down
  end
end
