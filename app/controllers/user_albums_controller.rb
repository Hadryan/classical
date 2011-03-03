class UserAlbumsController < ApplicationController
  before_filter :find_user_album, :only => [:show, :edit, :update]

  def index
    params[:search] ||= {}

    if !params[:search].blank? || params[:type]
      params[:search] = {"album_#{params[:type]}_name_contains" => params['query']} if params[:search].blank?
      type_key = params[:search].keys.grep(/contains/).first
      @query = params[:search][type_key]
      @type = type_key[0..-15] if type_key
    end

    @user_album_search = current_user.user_albums.search(params[:search])
    @user_albums = @user_album_search.paginate(:page => params[:page])
  end

  def show
    @album = @user_album.album
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user_album.update_attributes(params[:user_album])
        #'Album was successfully created.'
        format.html { redirect_to @user_album, :notice => I18n.t('.update_msg') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  private

  def find_user_album
    @user_album = UserAlbum.find(params[:id])
  end
end

