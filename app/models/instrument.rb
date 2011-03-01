# == Schema Information
#
# Table name: instruments
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Instrument < ActiveRecord::Base
  has_many :albums
  has_many :discussions, :as => :discussable

  validates :name, :presence => true, :uniqueness => true
end

