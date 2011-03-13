# == Schema Information
#
# Table name: user_albums
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  album_id   :integer
#  cd_number  :integer
#  location   :string(255)
#  favorite   :boolean
#  review_id  :integer
#  rating     :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserAlbum < ActiveRecord::Base
  belongs_to :user
  belongs_to :album

  accepts_nested_attributes_for :album

  validates :user_id, :presence => true, :uniqueness => {:scope => :album_id}
  validates :cd_number, :numericality => true, :allow_blank => true
end

