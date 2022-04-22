class AuthenticatedController < ApplicationController
  around_action :set_local_user

  private

  def set_local_user
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("SET LOCAL ROLE #{session[:username]}")
      yield
    end
  rescue => exception
    if exception.to_s.include? 'PG::InsufficientPrivilege'
      render body: exception, status: :forbidden
    else
      raise
    end
  end
end
