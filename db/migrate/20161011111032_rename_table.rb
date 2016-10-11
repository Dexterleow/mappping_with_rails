class RenameTable < ActiveRecord::Migration
  def change
     rename_table :users, :stores
  end
end
