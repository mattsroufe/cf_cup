class AddCourseHoleForeignKey < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :holes, :courses
  end
end
