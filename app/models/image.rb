# == Schema Information
#
# Table name: images
#
#  id                      :integer         not null, primary key
#  alt                     :string(255)
#  imageable_id            :integer
#  imageable_type          :string(255)
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  created_by              :integer
#  created_at              :datetime
#  updated_at              :datetime
#

class Image < ActiveRecord::Base

  has_attached_file :attachment, :styles => { :thumb => "64x64>", :small => "140x140>", :medium => "200x275>", :large => "313x264>" }

  belongs_to :imageable, :polymorphic => true

  validates_attachment_presence :attachment

end

