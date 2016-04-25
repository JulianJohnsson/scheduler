class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
    	t.string :name
    	t.string :google_calendar_id

      	t.timestamps null: false
    end
  end
end
