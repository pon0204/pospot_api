class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true, null: false
      t.string :nickname
      t.text :introduction #長文はtext
      t.string :gender
      t.string :twitter_url
      t.string :instagram_url
      t.timestamps
    end
  end
end
