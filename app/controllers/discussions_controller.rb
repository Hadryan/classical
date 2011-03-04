class DiscussionsController < ApplicationController

  def create
    @discussable = find_discussable
    @discussion = @discussable.discussions.build(params[:discussion].merge!(:user => current_user))
    if @discussion.save
      flash[:notice] = "Successfully saved discussion."
      redirect_to @discussable
    else
      render :action => 'new'
    end
  end

  def find_discussable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end

    nil
  end
end

