class AddNickNameToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :nick_name, :string
  end
end
