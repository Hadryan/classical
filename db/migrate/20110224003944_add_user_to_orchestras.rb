class AddUserToOrchestras < ActiveRecord::Migration
  def self.up
    add_column :orchestras, :user_id, :integer
  end

  def self.down
    remove_column :orchestras, :user_id
  end
end
