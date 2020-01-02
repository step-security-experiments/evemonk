# frozen_string_literal: true

module Eve
  class UpdateTypesJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::Error::TimeoutError

    def perform(page = 1)
      Eve::TypesImporter.new(page).import
    end
  end
end
