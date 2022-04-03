class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.integer :course_id
      t.date :date

      t.timestamps
    end
  end
end
