class CreateUserAlbums < ActiveRecord::Migration
  def self.up
    create_table :user_albums do |t|
      t.belongs_to :user
      t.belongs_to :album
      t.integer :cd_number
      t.string :location
      t.boolean :favorite
      t.integer :review_id
      t.integer :rating

      t.timestamps
    end
  end

  def self.down
    drop_table :user_albums
  end
end

