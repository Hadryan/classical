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

class Discussion < ActiveRecord::Base
  belongs_to :discussable, :polymorphic => true
  belongs_to :user

  validates :user_id, :content, :presence => true
end

