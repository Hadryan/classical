class OrchestrasController < ApplicationController
  before_filter :find_orchestra,  :only => [:show, :edit, :update, :destroy]

  def index
    @orchestras = Orchestra.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"], :order => :name)
  end

  def new
    @orchestra = Orchestra.new
  end

  def edit
  end

  def show
  end

  def create
    @orchestra = Orchestra.new(params[:orchestra])

    respond_to do |format|
      if @orchestra.save
        flash[:notice] = 'Orchestra was successfully created.'
        format.html { redirect_to(@orchestra) }
        format.xml  { render :xml => @orchestra, :status => :created,
                    :location => @orchestra }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orchestra.errors,
                    :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @orchestra.update_attributes(params[:orchestra])
        flash[:notice] = 'Orchestra was successfully updated.'
        format.html { redirect_to(@orchestra) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @orchestra.errors,  :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @orchestra.destroy

     respond_to do |format|
       format.html { redirect_to(orchestras_url) }
       format.xml { head :ok }
     end
  end

  def orchestra_completion

    prefix = params[:prefix]
    matches = Orchestra.find(:all, :conditions => ["name like ?", "%#{prefix}%"], :order => :name)

    if matches.empty?
      render :text => "The serch returns any result"
    else
      render :partial => 'result', :collection => matches
    end

  end

  private
    def find_orchestra
      @orchestra = Orchestra.find(params[:id])
    end
end
