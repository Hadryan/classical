require 'rubygems'
require 'hpricot'
require 'open-uri'

class ComposersController < ApplicationController
  before_filter :find_composer,  :only => [:show, :edit, :update, :destroy, :wiki_data ]

  def index
    @composers = Composer.paginate :page => params[:page], :order => :last_name
  end

  def new
    @composer = Composer.new
  end

  def edit

  end

  def update
    respond_to do |format|
      if @composer.update_attributes(params[:composer])
        flash[:notice] = 'Composer was successfully updated.'
        format.html { redirect_to(@composer) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @composer.errors,  :status => :unprocessable_entity }
      end
    end
  end

  def show

  end

  def wiki_data
    begin
      locale = 'en'
      locale = current_user.app_language.locale_name[0,2] unless current_user.app_language.nil?

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
        flash[:notice] = 'Composer was successfully created.'
        format.html { redirect_to(@composer) }
        format.xml  { render :xml => @composer, :status => :created,
                    :location => @composer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @composer.errors,
                    :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @composer.destroy

     respond_to do |format|
       format.html { redirect_to(composers_url) }
       format.xml { head :ok }
     end
  end

  def composers_completion
    matches = Composer.find_by_name_like params[:prefix]

    if matches.empty?
      render :text => "The search returns any results."
    else
      render :partial => 'composer', :collection => matches
    end
  end

  private
    def find_composer
      @composer = Composer.find(params[:id])
    end
end

