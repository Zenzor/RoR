class CreateDoors < ActiveRecord::Migration
  def change
    create_table :doors do |t|
      t.text :content
      t.date :unlock_date

      t.timestamps
    end
  end
end
