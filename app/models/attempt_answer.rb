class AttemptAnswer < ApplicationRecord
  belongs_to :answer
  belongs_to :question
  belongs_to :exam_attempt
end
