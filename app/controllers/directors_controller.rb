class DirectorsController < ApplicationController
  before_filter :find_director,  :only => [:show, :edit, :update, :destroy]
  
  def index
    @directors = Directors.find(:all)
  end

  def new
    @director = Directors.new
  end

  def edit
  end

  def show
  end

  def create
    @director = Directors.new(params[:director])

    respond_to do |format|
      if @director.save
        flash[:notice] = 'Solist was successfully created.'
        format.html { redirect_to(@director) }
        format.xml  { render :xml => @director, :status => :created,
                    :location => @director }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @director.errors,
                    :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @director.update_attributes(params[:director])
        flash[:notice] = 'Director was successfully updated.'
        format.html { redirect_to(@director) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @director.errors,  :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @director.destroy

     respond_to do |format|
       format.html { redirect_to(directors_url) }
       format.xml { head :ok }
     end
  end

  private
    def find_director
      @director = Directors.find(params[:id])
    end
end
