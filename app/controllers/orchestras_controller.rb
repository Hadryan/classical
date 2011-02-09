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
    conditions = {"orchestra_id_equals" => @orchestra.id}
    conditions.merge!(params[:search]) if params[:search]
    @search = Album.search(conditions)
  end

  def create
    @orchestra = Orchestra.new(params[:orchestra])

    respond_to do |format|
      if @orchestra.save
        format.html { redirect_to(@orchestra, :notice => 'Orchestra was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @orchestra.update_attributes(params[:orchestra])
        format.html { redirect_to(@orchestra, :notice => 'Orchestra was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @orchestra.destroy

     respond_to do |format|
       format.html { redirect_to(orchestras_url) }
     end
  end

  def orchestra_completion
    @orchestras = Orchestra.find_by_name_like params[:prefix]

    if @orchestras.empty?
      render :text => I18n.t(:no_results)
    else
      render :partial => @orchestras
    end

  end

  private
    def find_orchestra
      @orchestra = Orchestra.find(params[:id])
    end
end

