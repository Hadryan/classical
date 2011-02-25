class UserAlbumsController < ApplicationController
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
end

