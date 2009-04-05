class SolistsController < ApplicationController
  before_filter :find_solist,  :only => [:show, :edit, :update, :destroy]
  
  def index
    
  end

  def new
    @solist = Solist.new
  end

  def edit
  end

  def show
  end

  def myresponse    
  end
  
  def get_time    
    render :text => Time.now
  end

  def solist_completion
    prefix = params[:prefix]

    @matches = Solist.find(:all, :conditions => ["name LIKE ?", "#{prefix}%"])

    if @matches.empty?
      render :text => "No solists found."
    else
      render :partial => 'result', :collection => @matches
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
