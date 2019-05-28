class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :internal_score
      t.references :sub_category, foreign_key: true

      t.timestamps
    end
  end
end
