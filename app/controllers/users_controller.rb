class UsersController < ApplicationController
	skip_before_filter :login_required

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
      redirect_back_or_default('/')
      flash[:success] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end

end

