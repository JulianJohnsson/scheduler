class AddFinishAtToEvents < ActiveRecord::Migration
  def change
    add_column :events, :finish_at, :date
  end
end
