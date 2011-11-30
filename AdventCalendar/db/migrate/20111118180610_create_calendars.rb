class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :title
      t.string :img_url
      t.integer :public

      t.timestamps
    end
  end
end
