class AppLanguage < ActiveRecord::Base
  has_many :users

	validates_presence_of :locale_name
	validates_presence_of :name
end
