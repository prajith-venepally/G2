class Search < ApplicationRecord
  belongs_to :searchable, polymorphic: true
  belongs_to :user
end
