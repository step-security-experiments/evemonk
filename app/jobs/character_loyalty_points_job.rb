# frozen_string_literal: true

class CharacterLoyaltyPointsJob < ActiveJob::Base
  queue_as :default

  retry_on EveOnline::Exceptions::Timeout,
    EveOnline::Exceptions::ServiceUnavailable,
    EveOnline::Exceptions::BadGateway,
    EveOnline::Exceptions::InternalServerError,
    OpenSSL::SSL::SSLError,
    Faraday::Error::TimeoutError

  def perform(character_id)
    CharacterLoyaltyPointsImporter.new(character_id).import
  end
end
