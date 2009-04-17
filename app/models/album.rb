class Album < ActiveRecord::Base
  belongs_to :composer
  belongs_to :obra_type
  belongs_to :solist
  belongs_to :director
  belongs_to :orchestra
  belongs_to :instrument
  
  def composer_name
    composer.name if composer
  end
  
  def composer_name=(name)
    self.composer = Composer.find_or_create_by_name(name) unless name.blank?
  end
  
  def obra_type_name
    obra_type.name if obra_type
  end
  
  def obra_type_name=(name)
    self.obra_type = ObraType.find_or_create_by_name(name) unless name.blank?
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
  
  def instrument_name
    instrument.name if instrument
  end
    
  def instrument_name=(name)
    self.instrument = Instrument.find_or_create_by_name(name) unless name.blank?
  end
end
