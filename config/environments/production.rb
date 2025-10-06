require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Código e assets carregados uma vez (melhor performance)
  config.cache_classes = true
  config.eager_load = true

  # Não mostrar erros detalhados em produção
  config.consider_all_requests_local = false

  # Cache ativado
  config.action_controller.perform_caching = true

  # Servir arquivos estáticos (caso não tenha Nginx cuidando disso)
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present? || true

  # Compressão e otimização de assets
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass
  config.assets.compile = false

  # Host base da aplicação (importantíssimo)
  Rails.application.routes.default_url_options[:host] = 'https://credenciamento.sejus.gov.br'
  config.action_mailer.default_url_options = { host: 'https://credenciamento.sejus.gov.br' }

  # Permite o host de produção
  config.hosts << "credenciamento.sejus.gov.br"

  # Armazenamento de arquivos
  config.active_storage.service = :local

  # Logs
  config.log_level = :info
  config.log_tags = [ :request_id ]
  config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

  # Fallback para traduções ausentes
  config.i18n.fallbacks = true

  # Cache store em memória (pode mudar pra Redis se quiser)
  config.cache_store = :memory_store

  # E-mails
  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = false

  # Garante que o schema não será exportado após migrações
  config.active_record.dump_schema_after_migration = false

  # Para segurança: impede que Rails aceite hosts não autorizados
  config.host_authorization = { exclude: ->(request) { request.local? } }

  # Se quiser logar direto no console (útil em deploys via Docker ou PaaS)
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end
end
