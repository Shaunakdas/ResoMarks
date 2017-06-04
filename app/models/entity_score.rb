class EntityScore < ApplicationRecord
  belongs_to :entity, polymorphic: true
  belongs_to :user
  belongs_to :exam_set
  belongs_to :exam
end
