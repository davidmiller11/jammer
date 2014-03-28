class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.boolean :confirmed
      t.boolean :allow_date_prop
      t.integer :creator_id

      t.timestamps
    end
  end
end
