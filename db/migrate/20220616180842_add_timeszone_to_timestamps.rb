class AddTimeszoneToTimestamps < ActiveRecord::Migration[7.0]
  def up
    # ALTER TABLE tbl ALTER ts_column TYPE timestamptz USING ts_column AT TIME ZONE 'UTC';
    [:courses, :scores, :holes, :match_teams, :teams, :players, :matches, :ar_internal_metadata].each do |table|
      change_column table, :created_at, 'timestamp(6) with time zone'
      change_column table, :updated_at, 'timestamp(6) with time zone'
    end
  end

  def down
    [:courses, :scores, :holes, :match_teams, :teams, :players, :matches, :ar_internal_metadata].each do |table|
      change_column table, :created_at, 'timestamp(6) without time zone'
      change_column table, :updated_at, 'timestamp(6) without time zone'
    end
  end
end
