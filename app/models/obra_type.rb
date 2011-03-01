# == Schema Information
#
# Table name: obra_types
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#

class ObraType < ActiveRecord::Base
  has_many :albums
  has_many :discussions, :as => :discussable
  has_one :image, :as => :imageable

  accepts_nested_attributes_for :image, :allow_destroy => true

  validates :name, :presence => true, :uniqueness => true

  def to_s
    self.name
  end
end

