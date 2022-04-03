class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.text :strengths
      t.text :weaknesses
      t.string :handicap_text
      t.decimal :handicap

      t.timestamps
    end
  end
end
