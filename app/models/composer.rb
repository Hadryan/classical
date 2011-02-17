# == Schema Information
#
# Table name: composers
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  nationality :string(255)
#  birth_date  :date
#  death_date  :date
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  wiki_url    :string(255)
#

class Composer < ActiveRecord::Base
  has_many :albums
  has_one :image, :as => :imageable

  validates :name, :presence => true, :uniqueness => true

  accepts_nested_attributes_for :image, :allow_destroy => true

  def self.find_by_name_like(prefix)
    where('name ilike ?', "#{prefix}%").order(:name)
  end

  def wiki_url
    self.update_attribute(:wiki_url, Google::Search::Web.new(:language => 'es', :query => "#{self.name} wiki").first.uri) unless self.read_attribute(:wiki_url)
    self.read_attribute(:wiki_url)
  end

  private

end

