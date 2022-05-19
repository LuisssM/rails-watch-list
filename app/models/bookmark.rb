class Bookmark < ApplicationRecord
  belongs_to :list
  belongs_to :movie

  validates :list, uniqueness: { scope: :movie }
  validates_length_of :comment, minimum: 6
end
