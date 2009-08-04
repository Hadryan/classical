class SolistsController < ApplicationController
  before_filter :find_solist,  :only => [:show, :edit, :update, :destroy]
  
  def index
    @solists = Solist.find_by_name_like params[:search]
  end

  def new
    @solist = Solist.new
  end

  def edit
  end

  def show
  end

  def solist_completion
    @solists = Solist.find_by_name_like params[:prefix]

    if @solists.empty?
      render :text => "No solists found."
    else
      render :partial => @solists
    end
  end

  def create
    @solist = Solist.new(params[:solist])

    respond_to do |format|
      if @solist.save
        flash[:notice] = 'Solist was successfully created.'
        format.html { redirect_to(@solist) }
        format.xml  { render :xml => @solist, :status => :created,
                    :location => @solist }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @solist.errors,
                    :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @solist.update_attributes(params[:solist])
        flash[:notice] = 'Solist was successfully updated.'
        format.html { redirect_to(@solist) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @solist.errors,  :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @solist.destroy

     respond_to do |format|
       format.html { redirect_to(solists_url) }
       format.xml { head :ok }
     end
  end

  private
    def find_solist
      @solist = Solist.find(params[:id])
    end
end
