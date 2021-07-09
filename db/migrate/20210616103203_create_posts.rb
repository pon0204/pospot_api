class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.string :title, null: false
      t.text :caption
      t.string :genre
      t.string :with
      t.timestamps
    end
  end
end
