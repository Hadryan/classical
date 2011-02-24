class AddUserToObraTypes < ActiveRecord::Migration
  def self.up
    add_column :obra_types, :user_id, :integer
  end

  def self.down
    remove_column :obra_types, :user_id
  end
end
