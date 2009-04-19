class ChangeTableComposers < ActiveRecord::Migration
  def self.up
    change_table :composers do |t|
      t.rename :name, :first_name
      t.rename :birthDate, :birth_date
      t.rename :deathDate, :death_date
      t.string :last_name
    end
  end

  def self.down
    change_table :composers do |t|
      t.rename :first_name, :name
      t.remove :last_name      
    end
  end
end
