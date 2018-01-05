class Comment < ApplicationRecord
  belongs_to :user
  has_one :movie

  validates :text, presence: true
end
