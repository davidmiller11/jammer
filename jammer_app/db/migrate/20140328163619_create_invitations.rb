class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :event
      t.references :user
      t.references :date
      t.string  :response
      # need to limit to 'yes', 'no', 'ifnec'
    end
  end
end
