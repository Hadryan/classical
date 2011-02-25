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

require 'spec_helper'

describe UserAlbum do
  pending "add some examples to (or delete) #{__FILE__}"
end
