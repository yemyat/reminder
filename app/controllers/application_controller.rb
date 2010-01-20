# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
    def is_logged_in
    if !session[:profile_id]
      redirect_to :controller => 'profile', :action=> 'login'
    else
      @currentUser = Profile.find_by_id(session[:profile_id])
    end
  end
end
