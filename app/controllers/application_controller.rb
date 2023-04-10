class ApplicationController < ActionController::Base
    
    helper_method :current_user   #, :logged_in?

    def current_user
         @current_user ||= User.find(session[:user_id]) if session[:user_id]
        
    end
    # def logged_in?
    #     !!current_blogger
    # end
    def require_user
        if !blogger_signed_in?
            flash[:alert]= "You must be logged in to perform that action."
            # redirect_to login_path
            redirect_to new_blogger_session_path
        end
    end

end
