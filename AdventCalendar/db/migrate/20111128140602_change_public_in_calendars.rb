class ChangePublicInCalendars < ActiveRecord::Migration
  def up
    change_column :calendars, :public, :boolean
  end

  def down
    change_column :calendars, :public, :integer
  end
end
