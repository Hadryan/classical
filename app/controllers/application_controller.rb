# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  include AuthenticatedSystem
	
	before_filter :login_required
	before_filter :set_locale
  
  def set_locale
    # if this is nil then I18n.default_locale will be used
    I18n.locale = 'es-AR' 
  end

  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
