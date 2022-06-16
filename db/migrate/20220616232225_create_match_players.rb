class CreateMatchPlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :match_players, id: :uuid do |t|
      t.column :match_id, :uuid, null: false
      t.column :player_id, :uuid, null: false
      t.column :handicap, :numeric, null: false

      t.column :created_at, 'timestamp(6) with time zone', null: false
      t.column :updated_at, 'timestamp(6) with time zone', null: false
    end

    add_index :match_players, [:match_id, :player_id], unique: true
    add_index :match_players, :player_id
  end
end
