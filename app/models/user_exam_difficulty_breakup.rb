class UserExamDifficultyBreakup < ApplicationRecord
  belongs_to :exam_attempt
  belongs_to :difficulty_level
end
