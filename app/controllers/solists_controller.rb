class SolistsController < ApplicationController
  before_filter :find_solist,  :only => [:show, :edit, :update, :destroy]

  def index
    @solists = Solist.paginate :page => params[:page], :order => :name
  end

  def new
    @solist = Solist.new
  end

  def edit
  end

  def show
  end

  def solist_completion
    @solists = Solist.find_by_name_like params[:prefix]

    if @solists.empty?
      render :text => "No solists found."
    else
      render :partial => @solists
    end
  end

  def create
    @solist = Solist.new(params[:solist])

    respond_to do |format|
      if @solist.save
        format.html { redirect_to(@solist, :notice => 'Solist was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @solist.update_attributes(params[:solist])
        format.html { redirect_to(@solist, :notice => 'Solist was successfully updated.') }
    else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @solist.destroy

     respond_to do |format|
       format.html { redirect_to(solists_url) }
     end
  end

  private
    def find_solist
      @solist = Solist.find(params[:id])
    end
end

