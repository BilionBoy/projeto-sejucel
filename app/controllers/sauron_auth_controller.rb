class SauronAuthController < ApplicationController
  skip_before_action :require_login, only: [:login, :callback, :logout]

  def login
    client = openid_client
    redirect_to client.authorization_uri(
      scope: [:openid, :profile, :email],
      response_type: :code
    ), allow_other_host: true
  end

  def callback
    client = openid_client
    client.authorization_code = params[:code]
    access_token = client.access_token!
    user_info = access_token.userinfo!

    # pega dados básicos
    email = user_info.email
    name = user_info.name || user_info.preferred_username

    # cria ou atualiza o user local
    user = User.find_or_initialize_by(email: email)
    user.name = name
    user.provider = 'sauron'
    user.uid = user_info.sub
    user.save!

    session[:user_id] = user.id
    session[:user_name] = user.name
    session[:user_email] = user.email

    redirect_to root_path, notice: "Autenticado com sucesso!"
  rescue => e
    Rails.logger.error "Erro OIDC: #{e.message}"
    render plain: "Erro durante autenticação: #{e.message}"
  end

  def logout
    reset_session
    redirect_to root_path, notice: "Sessão encerrada."
  end

  private

 def openid_client
  OpenIDConnect::Client.new(
    identifier: ENV["SAURON_CLIENT_ID"],
    secret: ENV["SAURON_CLIENT_SECRET"],
    redirect_uri: ENV["SAURON_REDIRECT_URI"], # 👈 usa exatamente o mesmo valor
    authorization_endpoint: "#{ENV["SAURON_ISSUER"]}/connect/authorize",
    token_endpoint: "#{ENV["SAURON_ISSUER"]}/connect/token",
    userinfo_endpoint: "#{ENV["SAURON_ISSUER"]}/connect/userinfo"
  )
 end
end
