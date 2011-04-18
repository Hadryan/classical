# == Schema Information
#
# Table name: albums
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  composer_id   :integer
#  obra_type_id  :integer
#  music_tone    :string(255)
#  number        :integer
#  opus_number   :string(255)
#  solist_id     :integer
#  director_id   :integer
#  orchestra_id  :integer
#  created_at    :datetime
#  updated_at    :datetime
#  instrument_id :integer
#

class Album < ActiveRecord::Base
  belongs_to :composer
  belongs_to :obra_type
  belongs_to :solist
  belongs_to :director
  belongs_to :orchestra
  belongs_to :instrument

  has_many :users, :through => :user_albums
  has_many :user_albums
  has_many :discussions, :as => :discussable

  has_one :image, :as => :imageable

  accepts_nested_attributes_for :image, :allow_destroy => true

  validates :composer, :director, :name, :presence => true

  def owned_by?(user)
    self.users.include? user
  end

  def user_album_for_user(user)
    self.user_albums.where(:user_id => user).first
  end
end

