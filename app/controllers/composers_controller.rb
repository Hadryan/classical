class ComposersController < ApplicationController
  def index
    @composers = Composer.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @composers }
    end
  end

  def new
    @composer = Composer.new

    respond_to do |format|
      format.html # edit.html.erb
      format.xml { render :xml }
    end
  end

  def edit
    respond_to do |format|
      format.html # edit.html.erb
      format.xml { render :xml }
    end
  end

  def show
    @composer = Composer.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.xml { render :xml => @composer}
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
end
