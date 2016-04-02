class RemoveTagFromEvents < ActiveRecord::Migration
  def up
  	remove_index :events, [:tag_id]
  	remove_column :events, :tag_id
  end

  def down
  	add_reference :events, :tag, index: true
  end
end
