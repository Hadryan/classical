class ChangeTableAlbums < ActiveRecord::Migration
  def self.up
    change_table :albums do |t| 
      t.remove :instrument
    end
  end

  def self.down
    change_table :albums do |t| 
      t.string :instrument
    end
  end
end
