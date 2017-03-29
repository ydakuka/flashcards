Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  if ENV['REDIS_URL']
    config.action_controller.perform_caching = true
    config.action_mailer.perform_caching = true
    config.cache_store = :redis_store, ENV['REDIS_URL']
    config.action_dispatch.rack_cache = {
      metastore:   ENV['REDIS_URL'] + "/metastore",
      entitystore: ENV['REDIS_URL'] + "/entitystore"
    }
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    } else
    config.action_controller.perform_caching = false
    config.action_mailer.perform_caching = false
    config.cache_store = :null_store
  end

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.quiet = true
  config.i18n.available_locales = [:en, :ru]
end
