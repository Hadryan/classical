class Composer < ActiveRecord::Base
  has_many :albums

  validates_presence_of :last_name
  
  def self.find_by_name_like(name)
    find(:all, :conditions => ["first_name LIKE ? OR last_name LIKE ?", "%#{name}%", "%#{name}%"], :order => :last_name)    
  end
  
  def self.find_by_full_name(full_name)
    names = full_name.strip.split(',', 2)
    first_name = ''
    first_name = names.last.strip unless names.length == 1
    last_name = names.first.strip    
  
    find(:all, :conditions => { :first_name => first_name, :last_name => last_name })
  end
  
  def full_name
    years = '(' + birth_date.year.to_s + '-' + death_date.year.to_s + ')' unless birth_date.blank? && death_date.blank?
  
    [last_name_with_comma, first_name, years].compact.join(' ').strip
  end
  
  def full_name_without_dates
    [last_name_with_comma, first_name].compact.join(' ')      
  end
  
  def last_name_with_comma
    name = last_name
    name = [name, ','].compact.join if !first_name.blank? && !name.blank?   
    name  
  end
  
  def wiki_name
    [first_name, last_name].compact.join('_').sub(' ', '_')
  end
end
