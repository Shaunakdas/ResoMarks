class UserQuestionScore < ApplicationRecord
  belongs_to :question
  belongs_to :exam_attempt
  belongs_to :exam_set, optional: true
  belongs_to :score_name, optional: true
end
