class InstrumentsController < ApplicationController
  before_filter :find_instrument,  :only => [:show, :edit, :update, :destroy ]

  # GET /instruments
  # GET /instruments.xml
  def index
    @instruments = Instrument.paginate :page => params[:page], :order => :name
  end

  def show

  end

  def new
    @instrument = Instrument.new
  end

  # GET /instruments/1/edit
  def edit

  end

  # POST /instruments
  # POST /instruments.xml
  def create
    @instrument = Instrument.new(params[:instrument])

    respond_to do |format|
      if @instrument.save
        flash[:notice] = 'Instrument was successfully created.'
        format.html { redirect_to(@instrument) }
        format.xml  { render :xml => @instrument, :status => :created, :location => @instrument }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @instrument.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /instruments/1
  # PUT /instruments/1.xml
  def update
    respond_to do |format|
      if @instrument.update_attributes(params[:instrument])
        flash[:notice] = 'Instrument was successfully updated.'
        format.html { redirect_to(@instrument) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @instrument.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /instruments/1
  # DELETE /instruments/1.xml
  def destroy
    @instrument.destroy

    respond_to do |format|
      format.html { redirect_to(instruments_url) }
      format.xml  { head :ok }
    end
  end

  def instruments_completion
    @instruments = Instrument.find(:all, :conditions => ['name LIKE ?', "#{params[:prefix]}%"],
                                   :order => 'name')

    if @instruments.empty?
      render :text => "The search returns any results."
    else
      render :partial => @instruments
    end
  end

  private
    def find_instrument
      @instrument = Instrument.find(params[:id])
    end
end

