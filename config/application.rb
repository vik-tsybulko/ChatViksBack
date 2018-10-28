require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Chat
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = [:en, :ua]
    config.i18n.default_locale = :en
    config.assets.initialize_on_precompile = true
    config.browserify_rails.commandline_options = '-t babelify --fast --ignore node_modules'
    config.assets.paths << Rails.root.join('node_modules')
    config.time_zone = 'Europe/Kiev'
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
