class AlbumsController < ApplicationController
  before_filter :find_album,  :only => [:show, :edit, :update, :destroy]


  def index
    @albums = Album.all(:include => [:composer, :solist, :orchestra, :obra_type, :director])
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
    params[:album][:instrument_ids] ||= []

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

  def albums_completion
    prefix = params[:prefix]

    matches = Album.find(:all, :conditions => ["name like ?", "#{prefix}%"])

    if matches.empty?
      render :text => "The search returns any results."
    else
      render :partial => 'album', :collection => matches
    end
  end

  def add_instrument
    render(:update) do |page|
      instrument = Instrument.find_by_name(params[:value])

      page['album_instrument_ids'].value = instrument.id.to_s
      page.replace_html 'list_instruments', instrument.name
    end
  end

  private
  def find_album
    @album = Album.find(params[:id])
  end
end

