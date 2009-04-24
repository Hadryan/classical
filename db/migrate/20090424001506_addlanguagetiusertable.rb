class Addlanguagetiusertable < ActiveRecord::Migration
  def self.up
    change_table :users do |t| 
      t.references :app_language
    end
  end

  def self.down
    change_table :users do |t| 
      t.remove :language
    end
  end
end
