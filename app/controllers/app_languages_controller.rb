class AppLanguagesController < ApplicationController
	before_filter :find_app_language,  :only => [:show, :edit, :update, :destroy ]
  # GET /languages
  # GET /languages.xml
  def index
    @languages = AppLanguage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @languages }
    end
  end

  # GET /languages/1
  # GET /languages/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @language }
    end
  end

  # GET /languages/new
  # GET /languages/new.xml
  def new
    @language = AppLanguage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @language }
    end
  end

  # GET /languages/1/edit
  def edit
  end

  # POST /languages
  # POST /languages.xml
  def create
    @language = AppLanguage.new(params[:app_language])

    respond_to do |format|
      if @language.save
        flash[:notice] = 'Languages was successfully created.'
        format.html { redirect_to(@language) }
        format.xml  { render :xml => @language, :status => :created, :location => @language }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @language.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /languages/1
  # PUT /languages/1.xml
  def update
    respond_to do |format|
      if @language.update_attributes(params[:app_language])
        flash[:notice] = 'Languages was successfully updated.'
        format.html { redirect_to(@language) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @language.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /languages/1
  # DELETE /languages/1.xml
  def destroy
    @language.destroy

    respond_to do |format|
      format.html { redirect_to(app_languages_url) }
      format.xml  { head :ok }
    end
  end

	private
		def find_app_language
      @language = AppLanguage.find(params[:id])
    end
end
