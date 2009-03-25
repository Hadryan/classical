class CreateObraTypes < ActiveRecord::Migration
  def self.up
    create_table :obra_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :obra_types
  end
end
