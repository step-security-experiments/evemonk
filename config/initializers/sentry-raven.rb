# frozen_string_literal: true

Raven.configure do |config|
  config.dsn = ENV.fetch('SENTRY_DSN')

  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
