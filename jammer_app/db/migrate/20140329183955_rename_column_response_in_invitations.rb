class RenameColumnResponseInInvitations < ActiveRecord::Migration
  def change
    change_table :invitations do |t|
      t.rename :response, :rsvp
    end
  end
end
