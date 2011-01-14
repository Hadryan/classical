class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :authenticate_user!
	before_filter :set_locale
  before_filter :set_section

  helper_method :sort_column, :sort_direction

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

  def sort_column
    (params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end

