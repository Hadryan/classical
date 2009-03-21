class ComposersController < ApplicationController
  def index
     respond_to do |format|
       format.html # index.html.erb
       #format.xml { render :xml => @posts }
     end
  end

  def new
  end

  def edit
  end

end
