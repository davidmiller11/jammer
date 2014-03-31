class RenameEventIdToJamId < ActiveRecord::Migration
  def change
    rename_column :jam_times, :event_id, :jam_id
    rename_column :rsvps, :date_id, :jam_time_id
  end
end
