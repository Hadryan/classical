class Composer < ActiveRecord::Base
  has_many :albums

  validates_presence_of :last_name

  def self.find_by_name_like(full_name)
    first_name, last_name = extract_names(full_name) unless full_name.blank?

    first_name = last_name if first_name.blank?

    find(:all, :conditions => ["first_name LIKE ? OR last_name LIKE ?", "#{first_name}%", "#{last_name}%"], :order => :last_name)
  end

  def self.find_or_create_by_full_name(full_name)
    find_by_name_like(full_name).first
  end

  def self.find_by_full_name(full_name)
    first_name, last_name = extract_names(full_name)

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

  def self.extract_names(full_name)
    names = full_name.strip.split(',', 2)
    first_name = ''
    first_name = names.last.strip if names.length > 1
    last_name = ''
    last_name = names.first.strip unless names.first.blank?

    return first_name, last_name
  end
end

