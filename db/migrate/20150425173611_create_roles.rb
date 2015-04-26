class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :title
      t.string :desc
      t.integer :power

      t.timestamps null: false
    end
  end
end
