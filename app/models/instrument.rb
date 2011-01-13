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
  has_many :albums

  validates :name, :presence => true, :uniqueness => true

  def self.find_by_name_like(prefix)
    where('name ilike ?', "#{prefix}%").order(:name)
  end
end

