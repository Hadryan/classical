require 'csv'

FILE_NAME = "#{RAILS_ROOT}/db/data/data.csv"

namespace :importer do
  desc "Import initial data"
  task(:data => :environment) do

  end

  desc "Only import Directors"
  task(:director => :environment) do
    if File.exists?(FILE_NAME)
      CSV.open(FILE_NAME, 'r') do |row|
        albumName,composser,director,
        orchestra,solist,instrument,obraType,
        musicTone,obraNumber,opusNumber,cDNumber = row

        create_director(director)       
      end
    else
      puts "#{FILE_NAME} doesn't exist."
    end
  end
  
  desc "Only import Obra Types"
  task(:obra_type => :environment) do
    if File.exists?(FILE_NAME)
      CSV.open(FILE_NAME, 'r') do |row|
        albumName,composser,director,
        orchestra,solist,instrument,obraType,
        musicTone,obraNumber,opusNumber,cDNumber = row

        create_obra_type(obraType)       
      end
    else
      puts "#{FILE_NAME} doesn't exist."
    end
  end
  
  desc "Only import Composers"
  task(:composer => :environment) do
    if File.exists?(FILE_NAME)
      CSV.open(FILE_NAME, 'r') do |row|
        albumName,composser,director,
        orchestra,solist,instrument,obraType,
        musicTone,obraNumber,opusNumber,cDNumber = row

        create_composser(composser)
       
      end
    else
      puts "#{FILE_NAME} doesn't exist."
    end
  end
  
  desc "Only import Orchestras"
  task(:orchestra => :environment) do
    if File.exists?(FILE_NAME)
      CSV.open(FILE_NAME, 'r') do |row|
        albumName,composser,director,
        orchestra,solist,instrument,obraType,
        musicTone,obraNumber,opusNumber,cDNumber = row

        create_orchestra(orchestra)
       
      end
    else
      puts "#{FILE_NAME} doesn't exist."
    end
  end
  
  desc "Only import Solists"
  task(:solist => :environment) do
    if File.exists?(FILE_NAME)
      CSV.open(FILE_NAME, 'r') do |row|
        albumName,composser,director,
        orchestra,solist,instrument,obraType,
        musicTone,obraNumber,opusNumber,cDNumber = row

        create_solist(solist)
       
      end
    else
      puts "#{FILE_NAME} doesn't exist."
    end
  end
end

def create_orchestra(value)
  unless value.nil?
    new_orchestra = Orchestra.new
    
    new_orchestra.name = String.new
    
    gen(value.strip) {|a| new_orchestra.name << a if !a.nil?}
    
    unless Orchestra.find_by_name(new_orchestra.name)
      new_orchestra.save
      puts "New Orchestra - " + new_orchestra.name
    end      
  end
end

def create_solist(value)
  unless value.nil?
    new_solist = Solist.new
    new_solist.name = extract_name(value)
    
    unless Solist.find_by_name(new_solist.name)
      new_solist.save
      puts "New Solist - " + new_solist.name
    end      
  end
end

def create_composser(composser)
  unless composser.nil?
    new_composser = Composer.new
    new_composser.name = composser_name(composser)
    
    unless Composer.find_by_name(new_composser.name)
      new_composser.save
      puts "New Composer - " + new_composser.name
    end      
  end
end

def create_director(name)
  unless name.nil?
    new_director = Director.new
    new_director.name = extract_name(name)
    
    unless Director.find_by_name(new_director.name)
      new_director.save
      puts "New Director - " + new_director.name
    end
    
  end
end

def extract_name(value)
  unless value.nil?
    surname, name = value.split(",")
    
    name = "" if name.nil?
    surname = "" if surname.nil?

    name.strip!
    surname.strip!
    name_temp = String.new
    surname_temp = String.new
    
    gen(name) {|a| name_temp << a if !a.nil?}
    gen(surname) {|a| surname_temp << a if !a.nil?}

    name = name_temp.strip
    
    name << ' ' unless name.empty?
    
    name << surname_temp.strip  
    
    return name
  end
  
  return ''
end

def create_obra_type(value)
  unless value.nil?
    new_obra_type = ObraType.new
    
    new_obra_type.name = String.new
    
    gen(value.strip) {|a| new_obra_type.name << a if !a.nil?}
    
    unless ObraType.find_by_name(new_obra_type.name)
      new_obra_type.save
      puts "New ObraType - " + new_obra_type.name
    end      
  end
end

def create_orchestra(value)
  unless value.nil?
    new_orchestra = Orchestra.new
    
    new_orchestra.name = String.new
    
    gen(value.strip) {|a| new_orchestra.name << a if !a.nil?}
    
    unless Orchestra.find_by_name(new_orchestra.name)
      new_orchestra.save
      puts "New Orchestra - " + new_orchestra.name
    end      
  end
end

def create_composser(composser)
  unless composser.nil?
    new_composser = Composer.new
    new_composser.name = composser_name(composser)
    
    unless Composer.find_by_name(new_composser.name)
      new_composser.save
      puts "New Composer - " + new_composser.name
    end      
  end
end

def create_director(name)
  unless name.nil?
    new_director = Director.new
    new_director.name = extract_name(name)
    
    unless Director.find_by_name(new_director.name)
      new_director.save
      puts "New Director - " + new_director.name
    end
    
  end
end

def extract_name(value)
  unless value.nil?
    surname, name = value.split(",")
    
    name = "" if name.nil?
    surname = "" if surname.nil?

    name.strip!
    surname.strip!
    name_temp = String.new
    surname_temp = String.new
    
    gen(name) {|a| name_temp << a if !a.nil?}
    gen(surname) {|a| surname_temp << a if !a.nil?}

    name = name_temp.strip
    
    name << ' ' unless name.empty?
    
    name << surname_temp.strip  
    
    return name
  end
  
  return ''
end

def composser_name(composser)
  name = composser.split('-')[0] unless composser.nil?

  extract_name(name)
end

def gen(collection)
  collection.each(' ') { | s | yield s.capitalize! if !s.nil? } 
end

def ano(value)
  ano = value.split('-')[1] unless value.nil?
  ano = ano.strip unless ano.nil?
  
  return ano
end

def composser_name(composser)
  name = composser.split('-')[0] unless composser.nil?

  extract_name(name)
end

def gen(collection)
  collection.each(' ') { | s | yield s.capitalize! if !s.nil? } 
end

def ano(value)
  ano = value.split('-')[1] unless value.nil?
  ano = ano.strip unless ano.nil?
  
  return ano
end