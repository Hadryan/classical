# == Schema Information
#
# Table name: directors
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Director < ActiveRecord::Base
  has_many :albums
  has_one :image, :as => :imageable

  accepts_nested_attributes_for :image, :allow_destroy => true

  validates :name, :presence => true, :uniqueness => true

  def self.find_by_name_like(prefix)
    where('name ilike ?', "#{prefix}%")
  end

  def to_s
    self.name
  end
end

