# == Schema Information
#
# Table name: obra_types
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  user_id     :integer
#

class ObraType < ActiveRecord::Base
  has_many :albums
  has_one :image, :as => :imageable
  belongs_to :user

  accepts_nested_attributes_for :image, :allow_destroy => true

  validates :name, :presence => true, :uniqueness => true
  validates :user, :presence => true

  def self.find_by_name_like(name)
    where("name ilike ?", "#{name}%").order(:name)
  end

  def to_s
    self.name
  end
end

