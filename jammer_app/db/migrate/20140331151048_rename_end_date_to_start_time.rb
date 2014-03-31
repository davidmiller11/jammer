class RenameEndDateToStartTime < ActiveRecord::Migration
  def change
    change_table :dates do |t|
      t.rename :end_date, :start_time
    end
  end
end
