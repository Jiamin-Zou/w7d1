class SessionsController < ApplicationController

    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:destroy]

    def new
        @user = User.new
        render :new #brings us to login page. sessions persist until you're logged out. so when we're logging in, we're also generating a new session (token) until logout
    end

    def create
        username = params[:user][:username]
        password = params[:user][:password]

        @user = User.find_by_credentials(username, password)

        if @user
            login!(@user)
            #this is just login!(@user)
            redirect_to cats_url
        else
            @user = User.new(username: username)
            render :new
        end
    end

    def destroy
        current_user.reset_session_token! if logged_in?
        session[:session_token] = nil
        @current_user = nil

        redirect_to new_session_url
    end
end
