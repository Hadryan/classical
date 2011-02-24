class AddUserToDirectors < ActiveRecord::Migration
  def self.up
    add_column :directors, :user_id, :integer
  end

  def self.down
    remove_column :directors, :user_id
  end
end
