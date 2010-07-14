class OrchestrasController < ApplicationController
  before_filter :find_orchestra,  :only => [:show, :edit, :update, :destroy]

  def index
    @orchestras = Orchestra.paginate :page => params[:page], :order => :name
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
    @orchestras = Orchestra.find_by_name_like params[:prefix]

    if @orchestras.empty?
      render :text => "The serch returns any result"
    else
      render :partial => @orchestras
    end

  end

  private
    def find_orchestra
      @orchestra = Orchestra.find(params[:id])
    end
end

