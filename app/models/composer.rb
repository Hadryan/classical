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
#  user_id     :integer
#

class Composer < ActiveRecord::Base
  has_many :albums
  has_many :discussions, :as => :discussable

  has_one :image, :as => :imageable

  belongs_to :user

  validates :name, :presence => true, :uniqueness => true
  validates :user, :presence => true

  accepts_nested_attributes_for :image, :allow_destroy => true

  def wiki_url
    self.update_attribute(:wiki_url, (Google::Search::Web.new(:language => 'es', :query => "#{self.name} wiki").first.uri rescue nil)) unless self.read_attribute(:wiki_url)
    self.read_attribute(:wiki_url)
  end
end

