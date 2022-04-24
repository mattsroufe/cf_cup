class AuthenticatedController < ApplicationController
  around_action :set_local_user

  private

  def set_local_user
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("SET LOCAL ROLE #{session[:username]}")
      yield
    end
  rescue *[PG::InsufficientPrivilege, ActiveRecord::StatementInvalid] => exception
    render body: exception, status: :forbidden
  end
end
