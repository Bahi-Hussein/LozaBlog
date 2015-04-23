class RemoveTimeStampFromLikes < ActiveRecord::Migration
  def change
  	remove_column :likes, :created_at
  	remove_column :likes, :updated_at
  end
end
