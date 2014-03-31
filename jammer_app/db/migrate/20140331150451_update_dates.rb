class UpdateDates < ActiveRecord::Migration
  def change
    remove_column :dates, :proposer_id, :integer
    remove_column :dates, :date_to, :date
    remove_column :dates, :time_to, :time
    add_column :dates, :event_id, :integer
    add_index :dates, :event_id

    change_table :dates do |t|
      t.rename :date_from, :start_date
      t.rename :time_from, :end_date
    end

  end
end
