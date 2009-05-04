class Album < ActiveRecord::Base
  belongs_to :composer
  belongs_to :obra_type
  belongs_to :solist
  belongs_to :director
  belongs_to :orchestra
  has_and_belongs_to_many :instruments

  def composer_full_name
    composer.full_name if composer
  end

  def composer_full_name=(name)
    self.composer = Composer.find_or_create_by_full_name(name) unless name.blank?
  end

  def obra_type_name
    obra_type.name if obra_type
  end

  def obra_type_name=(name)
    self.obra_type = ObraType.find_or_create_by_name(name) unless name.blank?
  end

  def instruments_name
    instruments[0].name if instruments
  end

  def instruments_name=(name)
    self.instruments << Instrument.find_or_create_by_name(name) unless name.blank?
  end

  def director_name
    director.name if director
  end

  def director_name=(name)
    self.director = Director.find_or_create_by_name(name) unless name.blank?
  end

  def orchestra_name
    orchestra.name if orchestra
  end

  def orchestra_name=(name)
    self.orchestra = Orchestra.find_or_create_by_name(name) unless name.blank?
  end

  def solist_name
    solist.name if solist
	end

  def solist_name=(name)
    self.solist = Solist.find_or_create_by_name(name) unless name.blank?
  end
end

