class AlbumsController < ApplicationController
  before_filter :find_album,  :only => [:show, :edit, :update, :destroy]

  def index
    @albums = Album.find(:all)
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
        flash[:notice] = 'Album was successfully created.'
        format.html { redirect_to(@album) }
        format.xml  { render :xml => @album, :status => :created,
                    :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors,
                    :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update_attributes(params[:album])
        flash[:notice] = 'Album was successfully updated.'
        format.html { redirect_to(@album) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @album.errors,  :status => :unprocessable_entity }
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
      render :partial => 'result', :collection => matches
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

