class UpdateEventsTable < ActiveRecord::Migration
  def change
    remove_column :events, :allow_date_prop, :boolean

    change_table :events do |t|
      t.rename :creator_id, :user_id
    end

    add_index :events, :user_id

  end
end
