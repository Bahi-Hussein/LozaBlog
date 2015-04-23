class RemovePassDigestFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :pass_digest
  end
end
