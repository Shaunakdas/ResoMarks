class ExamAttempt < ApplicationRecord
  belongs_to :exam, optional: true
  belongs_to :exam_set, optional: true
  belongs_to :user
end
