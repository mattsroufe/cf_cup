class CreateHoles < ActiveRecord::Migration[7.0]
  def change
    create_table :holes do |t|
      t.integer :course_id
      t.integer :par
      t.integer :stroke
      t.integer :meters
      t.integer :number

      t.timestamps
    end
  end
end
