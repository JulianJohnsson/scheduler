class AddStartAtToEvents < ActiveRecord::Migration
  def change
    add_column :events, :start_at, :date
  end
end
