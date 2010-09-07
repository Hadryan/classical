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

class Album < ActiveRecord::Base
  belongs_to :composer
  belongs_to :obra_type
  belongs_to :solist
  belongs_to :director
  belongs_to :orchestra
  has_and_belongs_to_many :instruments

  has_attached_file :photo, :styles => { :thumb => "150x150>",
                                         :small => "100x100" }

 # validates_presence_of   :composer, :obra_type, :name, :solist, :director, :orchestra, :instruments

  def composer_full_name
    composer.full_name if composer
  end

  def composer_full_name=(name)
    self.composer = Composer.find_by_full_name(name) unless name.blank?
  end

  def obra_type_name
    obra_type.name if obra_type
  end

  def obra_type_name=(name)
    self.obra_type = ObraType.find_by_name(name) unless name.blank?
  end

  def director_name
    director.name if director
  end

  def director_name=(name)
    self.director = Director.find_by_name(name) unless name.blank?
  end

  def orchestra_name
    orchestra.name if orchestra
  end

  def orchestra_name=(name)
    self.orchestra = Orchestra.find_by_name(name) unless name.blank?
  end

  def solist_name
    solist.name if solist
	end

  def solist_name=(name)
    self.solist = Solist.find_by_name(name) unless name.blank?
  end
end

