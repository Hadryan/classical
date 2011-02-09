class DirectorsController < ApplicationController
  before_filter :find_director,  :only => [:show, :edit, :update, :destroy]

  def index
    @directors = Director.paginate :page => params[:page], :order => :name
  end

  def new
    @director = Director.new
  end

  def edit
  end

  def show
    conditions = {"director_id_equals" => @director.id}
    conditions.merge!(params[:search]) if params[:search]
    @search = Album.search(conditions)
  end

  def create
    @director = Director.new(params[:director])

    respond_to do |format|
      if @director.save
        format.html { redirect_to(@director, :notice => 'Director was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @director.update_attributes(params[:director])
        format.html { redirect_to(@director, :notice => 'Director was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @director.destroy

     respond_to do |format|
       format.html { redirect_to(directors_url) }
     end
  end

  def director_completion
    matches = Director.find_by_name_like params[:prefix]

    if matches.empty?
      render :text => I18n.t(:no_results)
    else
      render :partial => 'director', :collection => matches
    end
  end

  private
    def find_director
      @director = Director.find(params[:id])
    end
end

