class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :set_section

  rescue_from Acl9::AccessDenied, :with => :not_allowed

  private

  def set_section
    @section = params[:controller]
  end

  def not_allowed
    redirect_to root_url, :notice => "You don't have permission to access this page"
  end
end

