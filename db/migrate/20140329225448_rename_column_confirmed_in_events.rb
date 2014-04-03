class RenameColumnConfirmedInEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.rename :confirmed, :finalized
    end
  end
end
