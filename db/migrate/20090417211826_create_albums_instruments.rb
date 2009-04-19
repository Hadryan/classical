class CreateAlbumsInstruments < ActiveRecord::Migration
  def self.up
    create_table :albums_instruments, :id => false, :force => true do |t|
        t.integer :album_id
        t.integer :instrument_id
        
        t.timestamps
    end
  end

  def self.down
    drop_table :albums_instruments
  end
end
