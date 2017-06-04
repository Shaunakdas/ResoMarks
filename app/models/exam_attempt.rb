class ExamAttempt < ApplicationRecord
  belongs_to :exam
  belongs_to :exam_set
  belongs_to :user
end
