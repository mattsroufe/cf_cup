class AddUuidToAllTheTables < ActiveRecord::Migration[7.0]
  def change
    tables = [:courses, :holes, :match_teams, :matches, :players, :scores, :teams]
    tables.each do |table|
      add_column table, :uuid, :uuid, default: "gen_random_uuid()", null: false

      change_table table do |t|
        t.remove :id
        t.rename :uuid, :id
      end
      execute "ALTER TABLE #{table} ADD PRIMARY KEY (id);"
    end
  end
end
