class EntityScore < ApplicationRecord
  belongs_to :entity, polymorphic: true
  belongs_to :exam_attempt
  belongs_to :exam_set
  belongs_to :score_name
end
