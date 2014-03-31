class UpdateInvitationsTable < ActiveRecord::Migration
  def change
    add_index :invitations, :date_id
    add_index :invitations, :user_id
  end

  change_table :invitations do |t|
    t.rename :rsvp, :answer
  end

  def change
    rename_table :invitations, :rsvps
  end

end
