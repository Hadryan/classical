# == Schema Information
#
# Table name: instruments
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Instrument < ActiveRecord::Base
  has_and_belongs_to_many :albums

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.find_by_name_like(name)
    find(:all, :conditions => ["name like ?", "#{name}%"], :order => :name)
  end
end

