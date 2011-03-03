class ComposersController < ApplicationController
  before_filter :find_composer,  :only => [:show, :edit, :update, :destroy, :wiki_data ]

  def index
    @composers = Composer.paginate :page => params[:page], :order => :name
  end

  def new
    @composer = Composer.new
    @composer.build_image
  end

  def edit

  end

  def update
    respond_to do |format|
      if @composer.update_attributes(params[:composer])
        format.html { redirect_to(@composer, :notice => I18n.t('.update_msg')) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def show
    conditions = {"album_composer_id_equals" => @composer.id}
    conditions.merge!(params[:search]) if params[:search] && params[:search][:album_composer_id_equals]
    @user_album_search = current_user.user_albums.search(conditions)
    @user_albums = @user_album_search.paginate(:page => params[:page])

    conditions = {"composer_id_equals" => @composer.id}
    conditions.merge!(params[:search]) if params[:search] && params[:search][:composer_id_equals]
    @search = Album.search(conditions)
    @albums = @search.paginate(:page => params[:page])
  end

  def create
    @composer = current_user.composers.new(params[:composer])

    respond_to do |format|
      if @composer.save
        format.html { redirect_to(@composer, :notice => I18n.t('.create_msg')) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @composer.destroy

     respond_to do |format|
       format.html { redirect_to(composers_url) }
     end
  end

  def composers_completion
    matches = Composer.search(:name_starts_with => params[:prefix])

    if matches.length == 0
      render :text => I18n.t(:no_results)
    else
      render :partial => matches.relation
    end
  end

  private

  def find_composer
    @composer = Composer.find(params[:id])
  end
end

