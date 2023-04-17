class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in? #this makes @current_user availabe in the VIEWS

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def require_logged_out
        redirect_to users_url if logged_in?
    end

    def login!(user)
        session_token = user.reset_session_token!
        session[:session_token] = session_token
    end

end