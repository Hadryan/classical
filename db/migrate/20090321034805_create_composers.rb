class CreateComposers < ActiveRecord::Migration
  def self.up
    create_table :composers do |t|
      t.string :name
      t.string :nationality
      t.date :birth_date
      t.date :death_date
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :composers
  end
end

