class Image < ActiveRecord::Base

  has_attached_file :attachment, :styles => { :thumb => "64x64>", :small => "140x140>", :medium => "200x275>", :large => "313x264>" }

  belongs_to :imageable, :polymorphic => true

  validates_attachment_presence :attachment

end

