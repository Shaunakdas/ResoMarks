class ExamDifficultyBreakup < ApplicationRecord
  belongs_to :exam
  belongs_to :difficulty_level
end
