class UpdateAssociationColumnsToUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :holes, :course_uuid, :uuid, default: "gen_random_uuid()", null: false
    change_table :holes do |t|
      t.remove :course_id
      t.rename :course_uuid, :course_id
    end
    add_column :match_teams, :match_uuid, :uuid, default: "gen_random_uuid()", null: false
    change_table :match_teams do |t|
      t.remove :match_id
      t.rename :match_uuid, :match_id
    end
    add_column :match_teams, :team_uuid, :uuid, default: "gen_random_uuid()", null: false
    change_table :match_teams do |t|
      t.remove :team_id
      t.rename :team_uuid, :team_id
    end
    add_column :matches, :course_uuid, :uuid, default: "gen_random_uuid()", null: false
    change_table :matches do |t|
      t.remove :course_id
      t.rename :course_uuid, :course_id
    end
    add_column :players, :team_uuid, :uuid, default: "gen_random_uuid()", null: false
    change_table :players do |t|
      t.remove :team_id
      t.rename :team_uuid, :team_id
    end
    add_column :scores, :match_uuid, :uuid, default: "gen_random_uuid()", null: false
    change_table :scores do |t|
      t.remove :match_id
      t.rename :match_uuid, :match_id
    end
    add_column :scores, :hole_uuid, :uuid, default: "gen_random_uuid()", null: false
    change_table :scores do |t|
      t.remove :hole_id
      t.rename :hole_uuid, :hole_id
    end
    add_column :scores, :player_uuid, :uuid, default: "gen_random_uuid()", null: false
    change_table :scores do |t|
      t.remove :player_id
      t.rename :player_uuid, :player_id
    end
  end
end
