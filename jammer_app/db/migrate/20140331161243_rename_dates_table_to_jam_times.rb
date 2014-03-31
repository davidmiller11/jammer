class RenameDatesTableToJamTimes < ActiveRecord::Migration
  def change
    rename_table :dates, :jam_times
  end
end
