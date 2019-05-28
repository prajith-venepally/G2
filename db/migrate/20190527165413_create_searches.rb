class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :search_text
      t.references :searchable, polymorphic: true

      t.timestamps
    end
  end
end
