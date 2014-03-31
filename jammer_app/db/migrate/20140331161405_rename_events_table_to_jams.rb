class RenameEventsTableToJams < ActiveRecord::Migration
  def change
    rename_table :events, :jams
  end
end
