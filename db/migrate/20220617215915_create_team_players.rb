class CreateTeamPlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :team_players, id: :uuid do |t|
      t.column :team_id, :uuid, null: false
      t.column :player_id, :uuid, null: false

      t.column :created_at, 'timestamp(6) with time zone', null: false
      t.column :updated_at, 'timestamp(6) with time zone', null: false
    end

    add_index :team_players, [:team_id, :player_id], unique: true
    add_index :team_players, :team_id
    add_index :team_players, :player_id
  end
end
