class ObraTypesController < ApplicationController
  before_filter :find_obra_type,  :only => [:show, :edit, :update, :destroy]
  
  def index
    @obra_types = ObraType.find_by_name_like params[:search]
  end

  def new
    @obra_type = ObraType.new
  end

  def edit
  end

  def show
  end

  def create
    @obra_type = ObraType.new(params[:obra_type])

    respond_to do |format|
      if @obra_type.save
        flash[:notice] = 'ObraType was successfully created.'
        format.html { redirect_to(@obra_type) }
        format.xml  { render :xml => @obra_type, :status => :created,
                    :location => @obra_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @obra_type.errors,
                    :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @obra_type.update_attributes(params[:obra_type])
        flash[:notice] = 'ObraType was successfully updated.'
        format.html { redirect_to(@obra_type) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @obra_type.errors,  :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @obra_type.destroy

     respond_to do |format|
       format.html { redirect_to(obra_types_url) }
       format.xml { head :ok }
     end
  end


  def obra_completion
     matches = ObraType.find_by_name_like params[:prefix] 
    
     if matches.empty?
       render :text => "The search returns any results."
     else
       render :partial => 'obra_type', :collection => matches
     end
  end

  private
    def find_obra_type
      @obra_type = ObraType.find(params[:id])
    end
end
