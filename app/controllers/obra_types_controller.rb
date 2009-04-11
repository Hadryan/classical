class ObraTypesController < ApplicationController
  before_filter :find_obra_type,  :only => [:show, :edit, :update, :destroy]
  
  def index
    @obraTypes = ObraType.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"], :order => :name)
  end

  def new
    @obraType = ObraType.new
  end

  def edit
  end

  def show
  end

  def create
    @obraType = ObraType.new(params[:obra_type])

    respond_to do |format|
      if @obraType.save
        flash[:notice] = 'ObraType was successfully created.'
        format.html { redirect_to(@obraType) }
        format.xml  { render :xml => @obraType, :status => :created,
                    :location => @obraType }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @obraType.errors,
                    :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @obraType.update_attributes(params[:obra_type])
        flash[:notice] = 'ObraType was successfully updated.'
        format.html { redirect_to(@obraType) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @obraType.errors,  :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @obraType.destroy

     respond_to do |format|
       format.html { redirect_to(obra_types_url) }
       format.xml { head :ok }
     end
  end

  private
    def find_obra_type
      @obraType = ObraType.find(params[:id])
    end
end
