class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :score
      t.string :title
      t.text :text

      t.timestamps
      
      t.index [:user_id, :item_id], unique: true
    end
  end
end
