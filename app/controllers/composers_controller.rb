class ComposersController < ApplicationController
  before_filter :find_composer,  :only => [:show, :edit, :update, :destroy]
  
  def index
    @composers = Composer.find(:all) #, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
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

    matches = Composer.find(:all, :conditions => ["name like ?", "#{prefix}%"])

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
