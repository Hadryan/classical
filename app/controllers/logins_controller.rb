class LoginsController < ApplicationController
  def index
    render(:layout => false)
  end

  def loginUser
    render(:template => "home/index")
  end
end
