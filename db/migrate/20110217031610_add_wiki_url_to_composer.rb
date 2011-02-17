class AddWikiUrlToComposer < ActiveRecord::Migration
  def self.up
    add_column :composers, :wiki_url, :string
  end

  def self.down
    remove_column :composers, :wiki_url
  end
end
