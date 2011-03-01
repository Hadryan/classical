class RemoveUserIdFromAlbums < ActiveRecord::Migration
  def self.up
    remove_column :albums, :cd_number

    remove_column :albums, :user_id
    remove_column :composers, :user_id
    remove_column :directors, :user_id
    remove_column :instruments, :user_id
    remove_column :obra_types, :user_id
    remove_column :orchestras, :user_id
    remove_column :solists, :user_id
  end

  def self.down
    add_column :albums, :user_id, :integer
    add_column :composers, :user_id, :integer
    add_column :directors, :user_id, :integer
    add_column :instruments, :user_id, :integer
    add_column :obra_types, :user_id, :integer
    add_column :orchestras, :user_id, :integer
    add_column :solists, :user_id, :integer

    add_column :albums, :cd_number, :integer
  end
end

