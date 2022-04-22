class SessionsController < ApplicationController
  def new
  end

  def create
    player = Player.find_by!(username: params[:username])
    if player
      session[:username] = player.username
      redirect_to matches_path
    else
      flash.now.alert = “username”
      render "new"
    end
  end
end
