require 'csv'

FILE_NAME = "#{Rails.root}/db/data/data.csv"

namespace :importer do
  desc "Import initial data"
  task(:posta => :environment) do
    tasks = [ 'director',
              'obra_type',
              'composer',
              'orchestra',
              'solist',
              'instrument']

    line = 2

    CSV.foreach(FILE_NAME, :headers => true) do |row|
      name = row['album_name'].blank? ? 'Sin Nombre' : row['album_name'].capitalize


      composer_name, dates = row['composer'].split('-')

      birth_date = death_date = 0
      birth_date, death_date = dates.split('/') if dates

      composer_name.strip!

      composer_name = composer_name.blank? ? 'Anonimo' : composer_name.capitalize

      unless (composer = Composer.find_by_name(composer_name))
        composer = Composer.create({:name => composer_name, :birth_date => Date.civil(birth_date.to_i), :death_date => Date.civil(death_date.to_i)})
      end

      obra_type = row['obra_type'].blank? ? 'NN' : row['obra_type'].capitalize
      music_tone = row['nota'].blank? ? 'NN' : row['nota'].capitalize
      solist_name = row['solist'].blank? ? 'Anonimo' : row['solist'].capitalize
      director_name = row['director'].blank? ? 'Anonimo' : row['director'].capitalize
      orchestra_name = row['orchestra'].blank? ? 'Sin nombre' : row['orchestra'].capitalize
      instrument_name = row['instrument'].blank? ? 'NN' : row['instrument'].capitalize
      obra_number = row['obra_number']
      opus_number = row['opus_number']
      cd_number = row['cd_number']

      album = Album.create({
        :name => name,
        :composer => composer,
        :obra_type => ObraType.find_or_create_by_name(obra_type),
        :music_tone => music_tone,
        :solist => Solist.find_or_create_by_name(solist_name),
        :director => Director.find_or_create_by_name(director_name),
        :orchestra => Orchestra.find_or_create_by_name(orchestra_name),
        :instrument => Instrument.find_or_create_by_name(instrument_name),
        :opus_number => opus_number,
        :cd_number => cd_number,
        :number => obra_number
      }
      )

      puts "#{line} - #{album.name}"
      line += 1
    end
  end
end

