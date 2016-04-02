class AddTagsToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :tag, index: true, foreign_key: true
  end
end
