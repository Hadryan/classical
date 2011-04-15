class AlbumsController < ApplicationController
  before_filter :find_album,  :only => [:show, :edit, :update, :destroy]

  def index
    if params[:type]
      params[:search] = {"#{params[:type]}_name_contains" => params['query']}
      type_key = params[:search].keys.grep(/contains/).first
      @query = params[:search][type_key]
      @type = type_key[0..-15] if type_key
    end

    @search = current_user.albums.search(params[:search])
    @albums = @search.paginate(:page => params[:page])
  end

  def new
    @album = Album.new
  end

  def edit
  end

  def show
  end

  def create
    @album = current_user.albums.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, :notice => I18n.t('.create_msg')}
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update_attributes(params[:album])
        #'Album was successfully created.'
        format.html { redirect_to @album, :notice => I18n.t('.update_msg') }
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

  private
  def find_album
    @album = current_user.albums.find(params[:id])
  end
end

