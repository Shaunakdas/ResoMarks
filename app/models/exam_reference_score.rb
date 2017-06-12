class ExamReferenceScore < ApplicationRecord
  belongs_to :exam
  belongs_to :entity, polymorphic: true
end
