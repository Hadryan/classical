class Orchestra < ActiveRecord::Base
  has_many :albums

  validates_presence_of :name
end
