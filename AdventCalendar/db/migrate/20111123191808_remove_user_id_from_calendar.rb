class RemoveUserIdFromCalendar < ActiveRecord::Migration
  def up
    remove_column :calendars, :user_id
  end

  def down
    add_column :calendars, :user_id, :integer
  end
end
