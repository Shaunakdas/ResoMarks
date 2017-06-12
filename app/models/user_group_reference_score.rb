class UserGroupReferenceScore < ApplicationRecord
  belongs_to :user_entity_score
  belongs_to :group, polymorphic: true
  belongs_to :entity, polymorphic: true
end
