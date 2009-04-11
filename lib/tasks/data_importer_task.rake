require 'csv'

namespace :importer do
  desc "Import initial data"
  task(:data => :environment) do

  end
  
  desc "Only import Composers"
  task(:composer => :environment) do
    if File.exists?("#{RAILS_ROOT}/db/data/data.csv")
      CSV.open("#{RAILS_ROOT}/db/data/data.csv", 'r') do |row|
        albumName,composser,director,
        orchestra,solist,instrument,obraType,
        musicTone,obraNumber,opusNumber,cDNumber = row

        create_composser(composser)
       
      end
    else
      puts "#{RAILS_ROOT}/db/data/data.csv doesn't exist."
    end
  end
end

def create_composser(composser)
  if !composser.nil?
    new_composser = Composer.new
    new_composser.name = composser_name(composser)
    
    if !Composer.find_by_name(new_composser.name)
      new_composser.save
      puts "New Composer - " + new_composser.name
    end      
  end
end

def composser_name(composser)
  name = composser.split('-')[0] if !composser.nil?
  if !name.nil?
    surname, name = name.split(",")
    
    name = "" if name.nil?
    surname = "" if surname.nil?
    puts surname
    name.strip!
    name_temp = String.new
    surname_temp = String.new
    
    gen(name) {|a| name_temp << a if !a.nil?}
    gen(surname) {|a| surname_temp << a if !a.nil?}

    name = name_temp.strip + ' ' + surname_temp.strip  
    
    return name
  end
  
  return ''
end

def gen(collection)
  collection.each(' ') { | s | yield s.capitalize! if !s.nil? } 
end

def ano(value)
  ano = value.split('-')[1] if !value.nil?
  ano = ano.strip if !ano.nil?
  return ano
end