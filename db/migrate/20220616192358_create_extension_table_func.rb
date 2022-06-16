class CreateExtensionTableFunc < ActiveRecord::Migration[7.0]
  def up
    ActiveRecord::Base.connection.execute "CREATE EXTENSION tablefunc;"
  end

  def down
    ActiveRecord::Base.connection.execute "DROP EXTENSION tablefunc;"
  end
end
