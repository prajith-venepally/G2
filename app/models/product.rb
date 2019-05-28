class Product < ApplicationRecord
  belongs_to :sub_category
  has_many :feedbacks, dependent: :destroy
  has_many :searches, as: :searchable, dependent: :destroy
end
