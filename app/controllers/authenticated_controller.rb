class AuthenticatedController < ApplicationController
  LOCAL_USER = 'money'
  around_action :set_local_user

  private

  def set_local_user
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("SET LOCAL ROLE #{LOCAL_USER}")
    end
  end
end
