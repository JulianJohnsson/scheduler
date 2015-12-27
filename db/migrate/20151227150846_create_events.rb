class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :author
      t.text :description
      t.string :image_id

      t.timestamps null: false
    end
  end
end
