class DirectorsController < ApplicationController
  before_filter :find_director,  :only => [:show, :edit, :update, :destroy]

  def index
    @directors = current_user.directors.paginate :page => params[:page], :order => :name
  end

  def new
    @director = Director.new
  end

  def edit
  end

  def show
    conditions = {"director_id_equals" => @director.id}
    conditions.merge!(params[:search]) if params[:search]
    @search = current_user.albums.search(conditions)
    @albums = @search.paginate(:page => params[:page])
  end

  def create
    @director = current_user.directors.new(params[:director])

    respond_to do |format|
      if @director.save
        format.html { redirect_to(@director, :notice => I18n.t('.create_msg')) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @director.update_attributes(params[:director])
        format.html { redirect_to(@director, :notice => I18n.t('.update_msg')) }
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
    matches = current_user.directors.search(:name_starts_with => params[:prefix])

    if matches.length == 0
      render :text => I18n.t(:no_results)
    else
      render :partial => matches.relation
    end
  end

  private
    def find_director
      @director = current_user.directors.find(params[:id])
    end
end

