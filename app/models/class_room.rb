class ClassRoom < ApplicationRecord
	has_many :child

  validates :grade_code, :name, :short_name, :color, :teacher_name, presence: true
end
