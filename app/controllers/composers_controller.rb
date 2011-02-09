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
        format.html { redirect_to(@composer, :notice => 'Composer was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def show
    conditions = {"composer_id_equals" => @composer.id}
    conditions.merge!(params[:search]) if params[:search]
    @search = Album.search(conditions)
  end

  def wiki_data
    begin
      locale = 'es'

      url = "http://#{locale}.wikipedia.org/w/index.php?action=render&title=" + @composer.wiki_name

      @data = Hpricot(open(url))
      @data.search("//img[@src='/skins-1.5/common/images/magnify-clip.png']").remove
      @data.search("//span[@class='editsection']").remove
    rescue
      @data = "Data Composer Not Found." + url
    end
  end

  def create
    @composer = Composer.new(params[:composer])

    respond_to do |format|
      if @composer.save
        format.html { redirect_to(@composer, :notice => 'Composer was successfully created.') }
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
    matches = Composer.find_by_name_like(params[:prefix])

    if matches.empty?
      render :text => I18n.t(:no_results)
    else
      render :partial => matches
    end
  end

  private
    def find_composer
      @composer = Composer.find(params[:id])
    end
end

