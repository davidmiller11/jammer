class RemoveEventIdFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :event_id, :integer
  end
end
