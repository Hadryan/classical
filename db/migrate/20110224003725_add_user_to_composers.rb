class AddUserToComposers < ActiveRecord::Migration
  def self.up
    add_column :composers, :user_id, :integer
  end

  def self.down
    remove_column :composers, :user_id
  end
end
