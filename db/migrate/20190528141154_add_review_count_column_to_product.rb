class AddReviewCountColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :review_count, :integer, :default => 1
  end
end
