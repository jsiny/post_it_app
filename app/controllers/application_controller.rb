class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:error] = "You must be logged in to do that"
      redirect_to root_path
    end
  end

  def display_flash_for_vote(vote)
    if vote.valid?
      flash.now[:notice] = "Your vote was counted"
    else
      flash.now[:error] = "You can't vote on that more than once"
    end
  end
end
