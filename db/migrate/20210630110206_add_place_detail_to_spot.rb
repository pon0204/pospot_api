class AddPlaceDetailToSpot < ActiveRecord::Migration[6.0]
  def change
    add_column :spots, :place_detail, :string
  end
end
