# == Schema Information
#
# Table name: discussions
#
#  id               :integer         not null, primary key
#  user_id          :integer
#  content          :text
#  discussable_id   :integer
#  discussable_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Discussion do
  pending "add some examples to (or delete) #{__FILE__}"
end
