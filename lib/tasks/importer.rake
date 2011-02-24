require 'csv'

FILE_NAME = "#{Rails.root}/db/data/data.csv"

namespace :importer do
  desc "Import initial data"
  task(:posta => :environment) do
    line = 1

    CSV.foreach(FILE_NAME, :headers => true) do |row|
      name = row['album_name'].blank? ? 'Sin Nombre' : row['album_name'].strip.capitalize

      composer_name, dates = row['composer'].split('-')

      birth_date = death_date = 0
      birth_date, death_date = dates.split('/') if dates

      composer_name = composer_name.blank? ? 'Anonimo' : composer_name.strip.capitalize

      unless (composer = Composer.where(:name => composer_name).first)
        #TODO fix for postgres
        birth_date = birth_date.to_i == 0 ? nil : birth_date.to_i
        death_date = death_date.to_i == 0 ? nil : death_date.to_i

        composer = Composer.create({:name => composer_name, :birth_date => (birth_date.nil? ? birth_date : Date.civil(birth_date)), :death_date => (death_date.nil? ? death_date : Date.civil(death_date.to_i))})
      end

      obra_type = row['obra_type'].blank? ? 'NN' : row['obra_type'].strip.capitalize
      music_tone = row['nota'].blank? ? 'NN' : row['nota'].strip.capitalize
      solist_name = row['solist'].blank? ? 'Anonimo' : row['solist'].strip.capitalize
      director_name = row['director'].blank? ? 'Anonimo' : row['director'].strip.capitalize
      orchestra_name = row['orchestra'].blank? ? 'Sin nombre' : row['orchestra'].strip.capitalize
      instrument_name = row['instrument'].blank? ? 'NN' : row['instrument'].strip.capitalize
      obra_number = row['obra_number']
      opus_number = row['opus_number'].to_s.strip == '0' ? nil : row['opus_number']

      cd_number = row['cd_number'].to_i
      cd_number = cd_number == 0 ? nil : cd_number.abs

      album = Album.create({
        :name => name,
        :composer => composer,
        :obra_type => ObraType.where(:name => obra_type).first || ObraType.create(:name => obra_type),
        :music_tone => music_tone,
        :solist => Solist.where(:name => solist_name).first || Solist.create(:name => solist_name),
        :director => Director.where(:name => director_name).first || Director.create(:name => director_name),
        :orchestra => Orchestra.where(:name => orchestra_name).first || Orchestra.create(:name => orchestra_name),
        :instrument => Instrument.where(:name => instrument_name).first || Instrument.create(:name => instrument_name),
        :opus_number => opus_number,
        :cd_number => cd_number,
        :number => obra_number
      })

      puts "#{line} - #{album.name}"
      line += 1
    end
  end
end

