class RemoveUserIdFromAlbums < ActiveRecord::Migration
  def self.up
    remove_column :albums, :user_id
    remove_column :albums, :cd_number
  end

  def self.down
    add_column :albums, :user_id, :integer
    add_column :albums, :cd_number, :integer
  end
end

