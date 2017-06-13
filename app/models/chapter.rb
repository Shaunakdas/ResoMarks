class Chapter < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :standard, optional: true
  belongs_to :stream, optional: true
  has_many :topics
  has_many :sub_topics
  has_many :entity_scores, as: :entity
end
