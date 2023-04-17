class SessionsController < ApplicationController
    def new
        @user = User.new
        render :new #brings us to login page. sessions persist until you're logged out. so when we're logging in, we're also generating a new session (token) until logout
    end

    def create
        username = params[:username]
        password = params[:password]

        @user = User.find_by_credentials(username, password)

        if @user
            session_token = @user.reset_session_token!
            session[:session_token] = session_token
            #this is just login!(@user)
            redirect_to cats_url
        else
            @user = User.new(username: username)
            render :new
        end
    end

    def destroy

    end
end
