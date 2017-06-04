class Topic < ApplicationRecord
  belongs_to :subject
  belongs_to :standard
  belongs_to :chapter
  belongs_to :stream
  has_many :sub_topics
  has_many :entity_scores, as: :entity
end
