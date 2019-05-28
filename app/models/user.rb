class User < ApplicationRecord
  belongs_to :category
  has_many :feedbacks, dependent: :destroy
  has_many :searches
  has_many :bookmarks
end
