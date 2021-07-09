class CreateSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :spots do |t|
      t.references :post, foreign_key: true, null: false
      t.string :name
      t.string :map_url
      t.string :web_url
      t.string :place
      t.string :place_id
      t.timestamps
    end
  end
end
