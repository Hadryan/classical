class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :alt
      t.references :imageable, :polymorphic => true

      t.string :attachment_file_name, :attachment_content_type
      t.integer :attachment_file_size

      t.ingeger :created_by

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end

