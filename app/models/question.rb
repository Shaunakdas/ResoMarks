class Question < ApplicationRecord
  belongs_to :difficulty_level
  belongs_to :subject
  belongs_to :standard
  belongs_to :chapter
  belongs_to :stream
  belongs_to :subtopic
  belongs_to :exam
  belongs_to :exam_set
  has_many :answers
  has_many :entity_scores, as: :entity
end
