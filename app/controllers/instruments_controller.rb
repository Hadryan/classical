class InstrumentsController < ApplicationController
  before_filter :find_instrument,  :only => [:show, :edit, :update, :destroy ]

  # GET /instruments
  # GET /instruments.xml
  def index
    @instruments = Instrument.paginate :page => params[:page], :order => :name
  end

  def show
    conditions = {"instrument_id_equals" => @instrument.id}
    conditions.merge!(params[:search]) if params[:search]
    @search = Album.search(conditions)
    @albums = @search.paginate(:page => params[:page])
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
        format.html { redirect_to(@instrument, :notice => I18n.t('.create_msg')) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /instruments/1
  # PUT /instruments/1.xml
  def update
    respond_to do |format|
      if @instrument.update_attributes(params[:instrument])
        format.html { redirect_to(@instrument, :notice => I18n.t('.update_msg')) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /instruments/1
  # DELETE /instruments/1.xml
  def destroy
    @instrument.destroy

    respond_to do |format|
      format.html { redirect_to(instruments_url) }
    end
  end

  def instrument_completion
    @instruments = Instrument.find_by_name_like(params[:prefix])

    if @instruments.empty?
      render :text => I18n.t(:no_results)
    else
      render :partial => @instruments
    end
  end

  private
    def find_instrument
      @instrument = Instrument.find(params[:id])
    end
end

