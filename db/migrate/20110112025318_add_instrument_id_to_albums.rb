class AddInstrumentIdToAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :instrument_id, :integer
  end

  def self.down
    remove_column :albums, :instrument_id
  end
end
