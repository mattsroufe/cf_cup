class AuthenticatedController < ApplicationController
  LOCAL_USER = 'money'
  around_action :set_local_user

  private

  def set_local_user
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("SET LOCAL ROLE #{session[:username]}")
      yield
    end
  rescue ActiveRecord::StatementInvalid => exception
    render body: exception, status: :forbidden
  end
end