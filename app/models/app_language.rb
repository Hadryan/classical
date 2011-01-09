# == Schema Information
#
# Table name: app_languages
#
#  id          :integer         not null, primary key
#  locale_name :string(255)
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class AppLanguage < ActiveRecord::Base
  has_many :users

	validates_presence_of :locale_name
	validates_presence_of :name

end

