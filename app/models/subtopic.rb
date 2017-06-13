class Subtopic < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :standard, optional: true
  belongs_to :chapter, optional: true
  belongs_to :topic, optional: true
  belongs_to :stream, optional: true
  has_many :entity_scores, as: :entity
end
