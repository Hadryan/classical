# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  include AuthenticatedSystem

	#before_filter :login_required
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
    I18n.load_path += Dir[ File.join(RAILS_ROOT, 'lib', 'locale', '*.{rb,yml}') ]
  end

  filter_parameter_logging :password
end

