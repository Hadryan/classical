# == Schema Information
#
# Table name: instruments
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Instrument < ActiveRecord::Base
  has_many :albums
  belongs_to :user

  validates :name, :presence => true, :uniqueness => true
  validates :user, :presence => true

  def self.find_by_name_like(prefix)
    where('name ilike ?', "#{prefix}%").order(:name)
  end
end

