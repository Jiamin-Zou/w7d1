class ApplicationController < ActionController::Base
    helper_method :current_user #this makes @current_user availabe in the VIEWS

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

end