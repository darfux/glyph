class User::SessionController < ApplicationController
  def new
    @session = User::Session.new
  end

  def create
    session_params = params[:user_session]
    @user = User.find_by(account: session_params[:account])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to game_path
    else
      @session = User::Session.new
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
