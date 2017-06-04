class Stream < ApplicationRecord
  belongs_to :subject
  has_many :chapters
  has_many :topics
  has_many :sub_topics
  has_many :entity_scores, as: :entity
end
