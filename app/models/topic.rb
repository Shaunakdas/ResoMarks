class Topic < ApplicationRecord
  belongs_to :subject
  belongs_to :standard
  belongs_to :chapter
  belongs_to :stream
end
