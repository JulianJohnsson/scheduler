class AddContextToConversations < ActiveRecord::Migration
  def change
  	add_column :conversations, :context, :string
  	add_column :conversations, :question, :string
  	add_column :conversations, :isquestion, :boolean
  end
end
