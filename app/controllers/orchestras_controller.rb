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
    conditions = {"album_orchestra_id_equals" => @orchestra.id}
    conditions.merge!(params[:search]) if params[:search] && params[:search][:album_orchestra_id_equals]
    @user_album_search = current_user.user_albums.search(conditions)
    @user_albums = @user_album_search.paginate(:page => params[:page])

    conditions = {"orchestra_id_equals" => @orchestra.id}
    conditions.merge!(params[:search]) if params[:search] && params[:search][:orchestra_id_equals]
    @search = Album.search(conditions)
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
    @orchestras = Orchestra.search(:name_starts_with => params[:prefix])

    if @orchestras.length == 0
      render :text => I18n.t(:no_results)
    else
      render :partial => @orchestras.relation
    end

  end

  private
    def find_orchestra
      @orchestra = Orchestra.find(params[:id])
    end
end

