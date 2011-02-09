class ObraTypesController < ApplicationController
  before_filter :find_obra_type,  :only => [:show, :edit, :update, :destroy]

  def index
    @obra_types = ObraType.paginate :page => params[:page], :order => :name
  end

  def new
    @obra_type = ObraType.new
  end

  def edit
  end

  def show
    conditions = {"obra_type_id_equals" => @obra_type.id}
    conditions.merge!(params[:search]) if params[:search]
    @search = Album.search(conditions)
  end

  def create
    @obra_type = ObraType.new(params[:obra_type])

    respond_to do |format|
      if @obra_type.save
        format.html { redirect_to(@obra_type, :notice => 'ObraType was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @obra_type.update_attributes(params[:obra_type])
        format.html { redirect_to(@obra_type, :notice => 'ObraType was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @obra_type.destroy

     respond_to do |format|
       format.html { redirect_to(obra_types_url) }
     end
  end


  def obra_type_completion
     matches = ObraType.find_by_name_like params[:prefix]

     if matches.empty?
       render :text => I18n.t(:no_results)
     else
       render :partial => 'obra_type', :collection => matches
     end
  end

  private
    def find_obra_type
      @obra_type = ObraType.find(params[:id])
    end
end

