class CreateCalendarsUsers < ActiveRecord::Migration
  def change
    create_table :calendars_users, :id => false do |t|
      t.references :calendar, :user
    end
  end
end
