class AddUserToSolists < ActiveRecord::Migration
  def self.up
    add_column :solists, :user_id, :integer
  end

  def self.down
    remove_column :solists, :user_id
  end
end
