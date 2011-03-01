class ObraTypesController < ApplicationController
  before_filter :find_obra_type,  :only => [:show, :edit, :update, :destroy]

  def index
    @obra_types = ObraType.paginate :page => params[:page], :order => :name
  end

  def new
    @obra_type = ObraType.new
  end

  def edit
  end

  def show
    conditions = {"album_obra_type_id_equals" => @obra_type.id}
    conditions.merge!(params[:search]) if params[:search] && params[:search][:album_obra_type_id_equals]
    @user_album_search = current_user.user_albums.search(conditions)
    @user_albums = @user_album_search.paginate(:page => params[:page])

    conditions = {"obra_type_id_equals" => @obra_type.id}
    conditions.merge!(params[:search]) if params[:search] && params[:search][:obra_type_id_equals]
    @search = Album.search(conditions)
    @albums = @search.paginate(:page => params[:page])
  end

  def create
    @obra_type = current_user.obra_types.new(params[:obra_type])

    respond_to do |format|
      if @obra_type.save
        format.html { redirect_to(@obra_type, :notice => I18n.t('.create_msg')) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @obra_type.update_attributes(params[:obra_type])
        format.html { redirect_to(@obra_type, :notice => I18n.t('.update_msg')) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @obra_type.destroy

     respond_to do |format|
       format.html { redirect_to(obra_types_url) }
     end
  end


  def obra_type_completion
     matches = current_user.obra_types.search(:name_starts_with => params[:prefix])

     if matches.length == 0
       render :text => I18n.t(:no_results)
     else
       render :partial => matches.relation
     end
  end

  private
    def find_obra_type
      @obra_type = ObraType.find(params[:id])
    end
end

