# == Schema Information
#
# Table name: orchestras
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Orchestra < ActiveRecord::Base
  has_many :albums

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.find_by_name_like(name)
    find(:all, :conditions => ["name like ?", "#{name}%"], :order => :name)
  end

  def to_s
    self.name
  end
end

