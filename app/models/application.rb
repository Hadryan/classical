class Application
  def self.find_by_name_like(name)
    find(:all, :conditions => ["name like ?", "%#{name}%"], :order => :name)    
  end
end