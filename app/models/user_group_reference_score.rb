class UserGroupReferenceScore < ApplicationRecord
  belongs_to :entity_score
  belongs_to :group, polymorphic: true, optional: true
  belongs_to :entity, polymorphic: true
end
