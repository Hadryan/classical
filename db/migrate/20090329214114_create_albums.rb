class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :name
      t.references :composer
      t.references :obra_type
      t.string :music_tone
      t.integer :number
      t.string :opus_number
      t.string :instrument
      t.references :solist
      t.references :director
      t.references :orchestra
      t.integer :cd_number

      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
