class Subject < ApplicationRecord
	
  has_many :streams
  has_many :chapters
  has_many :topics
  has_many :sub_topics
  has_many :entity_scores, as: :entity
end
