class CreateAppLanguages < ActiveRecord::Migration
  def self.up
    create_table :app_languages do |t|
			t.string :locale_name
			t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :app_languages
  end
end
