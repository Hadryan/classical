class RegistrationsController < ApplicationController
  def index
    @user = User.new
    render(:layout => false)
  end

end
