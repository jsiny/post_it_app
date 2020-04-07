class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    access_denied unless logged_in?
  end

  def require_admin
    access_denied unless logged_in? and current_user.admin?
  end

  def display_flash_for_vote(vote)
    if vote.valid?
      flash.now[:notice] = "Your vote was counted"
    else
      flash.now[:error] = "You can't vote on that more than once"
    end
  end

  def access_denied
    flash[:error] = "You can't do that"
    redirect_to root_path
  end
end
