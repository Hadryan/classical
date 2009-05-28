require 'csv'

FILE_NAME = "#{RAILS_ROOT}/db/data/data.csv"

namespace :importer do
  desc "Import initial data"
  task(:all => :environment) do
    tasks = [ 'director',
              'obra_type',
              'composer',
              'orchestra',
              'solist',
              'instrument']

    tasks.each {|task| Rake::Task['importer:' + task].execute }
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

  desc "Only import Instruments"
  task(:instrument => :environment) do
    if File.exists?(FILE_NAME)
      CSV.open(FILE_NAME, 'r') do |row|
        albumName,composser,director,
        orchestra,solist,instrument,obraType,
        musicTone,obraNumber,opusNumber,cDNumber = row

        create_instrument(instrument)
      end
    else
      puts "#{FILE_NAME} doesn't exist."
    end
  end

  desc "Only import Composers"
  task(:composer => :environment) do
    if File.exists?(FILE_NAME)
      CSV.open(FILE_NAME, 'r') do |row|
        albumName,composer,director,
        orchestra,solist,instrument,obraType,
        musicTone,obraNumber,opusNumber,cDNumber = row

        create_composer(composer)
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

def create_instrument(value)
  unless value.nil?
    tokens = value.split(/,|-/)
    tokens.compact

    tokens.each do | name |
      new_instrument = Instrument.new

      new_instrument.name = String.new

      gen(name.strip) {|a| new_instrument.name << a if !a.nil?}

      unless Instrument.find_by_name(new_instrument.name)
        new_instrument.save
        puts "New Instrument - " + new_instrument.name
      end
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

def create_composer(composer)
  unless composer.nil?
    new_composer = Composer.new

    names = composer_name(composer)

    new_composer.first_name = names.first.strip
    new_composer.last_name = names.last.strip

    if Composer.find_by_full_name(new_composer.full_name).empty?
      new_composer.save
      puts "New Composer - " + new_composer.full_name
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

def gen(collection)
  collection.each(' ') { | s | yield s.capitalize! if !s.nil? }
end

def ano(value)
  ano = value.split('-')[1] unless value.nil?
  ano = ano.strip unless ano.nil?

  return ano
end

def composer_name(composer)
  name = composer.split('-', 2).first.strip unless composer.nil?

  surname, name = name.split(",")

  name = "" if name.nil?
  surname = "" if surname.nil?

  name.strip!
  surname.strip!
  name_temp = String.new
  surname_temp = String.new

  gen(name) {|a| name_temp << a if !a.nil?}
  gen(surname) {|a| surname_temp << a if !a.nil?}

  [name_temp, surname_temp]
end

def gen(collection)
  collection.each(' ') { | s | yield s.capitalize! if !s.nil? }
end

def ano(value)
  ano = value.split('-')[1] unless value.nil?
  ano = ano.strip unless ano.nil?

  return ano
end

