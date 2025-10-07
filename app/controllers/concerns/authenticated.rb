module Authenticated
  extend ActiveSupport::Concern

  included do
    before_action :require_login
  end

  private

  def require_login
    unless session[:user_id].present?
      redirect_to '/auth/login', alert: "Você precisa estar autenticado pelo Sauron."
    end
  end
end
