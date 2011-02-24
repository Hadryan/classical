# == Schema Information
#
# Table name: solists
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Solist < ActiveRecord::Base
  has_many :albums
  has_one :image, :as => :imageable
  belongs_to :user

  accepts_nested_attributes_for :image, :allow_destroy => true

  validates :name, :presence => true, :uniqueness => true
  validates :user, :presence => true

  def self.find_by_name_like(prefix)
    where('name ilike ?', "#{prefix}%").order(:name)
  end

  def to_s
    self.name
  end
end

