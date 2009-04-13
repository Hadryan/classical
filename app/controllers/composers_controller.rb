require 'rubygems'
require 'hpricot'
require 'open-uri'

class ComposersController < ApplicationController
  before_filter :find_composer,  :only => [:show, :edit, :update, :destroy]
  
  def index
    @composers = Composer.find(:all , :conditions => ['name LIKE ?', "%#{params[:search]}%"], :order => :name)
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
      data = ''          
    
    begin    
      data = Hpricot(open('http://en.wikipedia.org/w/index.php?action=render&title=' + @composer.name.sub(' ', '_') ))
      data.search("//img[@src='/skins-1.5/common/images/magnify-clip.png']").remove
    rescue
      data = "Data Composer Not Found."      
    end
    
    @title = data
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
    prefix = params[:prefix]
    matches = Composer.find(:all, :conditions => ["name like ?", "%#{prefix}%"], :order => :name)

    if matches.empty?
      render :text => "The search returns any results."
    else
      render :partial => 'result', :collection => matches
    end
  end

  private
  def find_composer
    @composer = Composer.find(params[:id])
  end
end
