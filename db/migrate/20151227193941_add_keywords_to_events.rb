class AddKeywordsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :keywords, :text
  end
end
