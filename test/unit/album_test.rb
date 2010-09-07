# == Schema Information
#
# Table name: albums
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  composer_id  :integer
#  obra_type_id :integer
#  music_tone   :string(255)
#  number       :integer
#  opus_number  :string(255)
#  solist_id    :integer
#  director_id  :integer
#  orchestra_id :integer
#  cd_number    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class AlbumTest < ActiveSupport::TestCase

end

