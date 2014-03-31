class UpdateRsvpsTable < ActiveRecord::Migration
  def change
    remove_column :rsvps, :event_id, :integer
    add_index :rsvps, :date_id
    add_index :rsvps, :user_id
  end
end
