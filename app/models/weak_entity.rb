class WeakEntity < ApplicationRecord
  belongs_to :exam_attempt
  belongs_to :entity, polymorphic: true
end
