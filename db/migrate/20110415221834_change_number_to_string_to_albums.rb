class ChangeNumberToStringToAlbums < ActiveRecord::Migration
  def self.up
    rename_column :albums, :number, :obra_number
    change_column :albums, :obra_number, :string
  end

  def self.down
    rename_column :albums, :obra_number, :number
    change_column :albums, :number, :integer
  end
end
