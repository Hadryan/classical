class AlbumsController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_filter :find_album,  :only => [:show, :edit, :update, :destroy]

  def index
    order = (params[:sort] || 'name') + ' ' + (params[:direction] || '')
    @albums = Album.paginate :include => [:composer, :solist, :orchestra, :obra_type, :director], :page => params[:page], :order => order
  end

  def new
    @album = Album.new
  end

  def edit
  end

  def show
  end

  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, :notice => 'Album was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to(@album, :notice => 'Album was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @album.destroy

     respond_to do |format|
       format.html { redirect_to(albums_url) }
       format.xml { head :ok }
     end
  end

  def search
    @albums = Album.paginate(:include => [:composer, :solist, :orchestra, :obra_type, :director], :joins => params[:type].to_sym, :page => params[:page], :conditions => {params[:type].pluralize => { :name => params[:query] }})
    render 'index'
  end

  private
  def find_album
    @album = Album.find(params[:id])
  end

  def sort_column
    (params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end

