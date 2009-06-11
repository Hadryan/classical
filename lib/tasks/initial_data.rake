def create_locale
  create_locale_unless_exists(:name => "English",
                :locale_name => "en-US")
  create_locale_unless_exists(:name => "Spanish",
                :locale_name => "es-AR")
end

def create_locale_unless_exists(options = {})
  unless AppLanguage.find_by_name(options[:name])
    AppLanguage.create!(options)
  end
end

namespace :db do
  desc "Load initial data"
  task :initial_data => :environment do |t|
    create_locale
  end
end

