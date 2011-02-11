class AddDescriptionToObraTypes < ActiveRecord::Migration
  def self.up
    add_column :obra_types, :description, :text
  end

  def self.down
    remove_column :obra_types, :description
  end
end
