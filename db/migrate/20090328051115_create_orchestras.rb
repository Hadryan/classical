class CreateOrchestras < ActiveRecord::Migration
  def self.up
    create_table :orchestras do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :orchestras
  end
end
