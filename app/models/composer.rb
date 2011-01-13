# == Schema Information
#
# Table name: composers
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  nationality :string(255)
#  birth_date  :date
#  death_date  :date
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Composer < ActiveRecord::Base
  has_many :albums
  has_one :image, :as => :imageable

  validates :name, :presence => true, :uniqueness => true

  accepts_nested_attributes_for :image, :allow_destroy => true

  def wiki_name
    [first_name, last_name].compact.join('_').sub(' ', '_')
  end

  def self.find_by_name_like(prefix)
    where('name ilike ?', "#{prefix}%")
  end

  private
    def full_name_without_dates
      [last_name_with_comma, first_name].compact.join(' ')
    end

    def last_name_with_comma
      name = last_name
      name = [name, ','].compact.join if !first_name.blank? && !name.blank?
      name
    end
end

