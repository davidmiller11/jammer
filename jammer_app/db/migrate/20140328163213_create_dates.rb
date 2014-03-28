class CreateDates < ActiveRecord::Migration
  def change
    create_table :dates do |t|
      t.date :date_from
      t.date :date_to
      t.time :time_from
      t.time :time_to
      t.integer :proposer_id
    end
  end
end
