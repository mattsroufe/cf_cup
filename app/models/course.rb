class Course < ApplicationRecord
  has_many :holes, dependent: :destroy
end
