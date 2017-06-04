class Chapter < ApplicationRecord
  belongs_to :subject
  belongs_to :standard
  belongs_to :stream
end
