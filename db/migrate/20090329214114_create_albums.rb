class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :name
      t.references :composer
      t.references :obraType
      t.string :musicTone
      t.integer :number
      t.string :opusNumber
      t.string :instrument
      t.references :solist
      t.references :director
      t.references :orchestra
      t.integer :cdNumber

      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
