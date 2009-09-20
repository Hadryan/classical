class UsersController < ApplicationController
	skip_before_filter :login_required
	before_filter :get_languages, :only => [:new, :edit, :show]

  # render new.rhtml
  def new

  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])

    if @user.save
      self.current_user = @user
      redirect_back_or_default home_path
      flash[:success] = "Thanks for signing up!"
    else
      get_languages
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.html { render :action => "edit" }
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User profile was successfully updated.'
        format.html { redirect_to current_user }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors,  :status => :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def get_languages
    @languages = AppLanguage.find(:all)
  end
end

