class AuthenticatedController < ApplicationController
  before_action :set_current_player

  def current_player
    @current_player
  end

  private

  def set_current_player
    @current_user = Player.find_by!(username: cookies.permanent[:username])
  end
end
