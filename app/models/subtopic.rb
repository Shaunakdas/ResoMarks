class Subtopic < ApplicationRecord
  belongs_to :subject
  belongs_to :standard
  belongs_to :chapter
  belongs_to :topic
  belongs_to :stream
end
