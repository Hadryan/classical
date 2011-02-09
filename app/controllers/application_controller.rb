class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :authenticate_user!
	before_filter :set_locale
  before_filter :set_section

  private

  def set_section
    @section = params[:controller]
  end

  def set_locale
		locale = 'es-AR'

		if current_user
      locale = current_user.app_language.locale_name unless current_user.app_language.nil?
		end

    I18n.locale = locale
    I18n.load_path += Dir[ File.join(Rails.root, 'lib', 'locale', '*.{rb,yml}') ]
  end
end

