class HomeController < ApplicationController
  layout "application"
  
  def index
    render(:text => "text_to_render")
  end
end
