class Chapter < ApplicationRecord
  belongs_to :subject
  belongs_to :standard
  belongs_to :stream
  has_many :topics
  has_many :sub_topics
  has_many :entity_scores, as: :entity
end
