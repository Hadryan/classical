# == Schema Information
#
# Table name: albums
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  composer_id   :integer
#  obra_type_id  :integer
#  music_tone    :string(255)
#  obra_number   :string(255)
#  opus_number   :string(255)
#  solist_id     :integer
#  director_id   :integer
#  orchestra_id  :integer
#  cd_number     :integer
#  created_at    :datetime
#  updated_at    :datetime
#  instrument_id :integer
#  user_id       :integer
#

class Album < ActiveRecord::Base
  belongs_to :composer
  belongs_to :obra_type
  belongs_to :solist
  belongs_to :director
  belongs_to :orchestra
  belongs_to :instrument
  belongs_to :user

  has_one :image, :as => :imageable

  accepts_nested_attributes_for :image, :allow_destroy => true

  validates :composer, :director, :presence => true
  validates :cd_number, :numericality => true, :allow_blank => true
  validates :user, :presence => true

end

