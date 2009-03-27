class CreateSolists < ActiveRecord::Migration
  def self.up
    create_table :solists do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :solists
  end
end
