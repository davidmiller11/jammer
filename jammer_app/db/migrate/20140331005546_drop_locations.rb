class DropLocations < ActiveRecord::Migration
  def change
    remove_column :events, :location_id, :integer
    
    drop_table(:locations)
  end
end
