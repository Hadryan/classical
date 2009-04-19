class Orchestra < ActiveRecord::Base
  has_many :albums

  validates_presence_of :name
  validates_uniqueness_of :name
  
  def self.find_by_name_like(name)
    find(:all, :conditions => ["name like ?", "%#{name}%"], :order => :name)    
  end
end
