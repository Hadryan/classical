class OrchestrasController < ApplicationController
  before_filter :find_orchestra,  :only => [:show, :edit, :update, :destroy]

  def index
    @orchestras = current_user.orchestras.paginate :page => params[:page], :order => :name
  end

  def new
    @orchestra = Orchestra.new
  end

  def edit
  end

  def show
    conditions = {"orchestra_id_equals" => @orchestra.id}
    conditions.merge!(params[:search]) if params[:search]
    @search = current_user.albums.search(conditions)
    @albums = @search.paginate(:page => params[:page])
  end

  def create
    @orchestra = current_user.orchestras.new(params[:orchestra])

    respond_to do |format|
      if @orchestra.save
        format.html { redirect_to(@orchestra, :notice => I18n.t('.create_msg')) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @orchestra.update_attributes(params[:orchestra])
        format.html { redirect_to(@orchestra, :notice => I18n.t('.update_msg')) }
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
    @orchestras = current_user.orchestras.search(:name_starts_with => params[:prefix])

    if @orchestras.length == 0
      render :text => I18n.t(:no_results)
    else
      render :partial => @orchestras.relation
    end

  end

  private
    def find_orchestra
      @orchestra = current_user.orchestras.find(params[:id])
    end
end

