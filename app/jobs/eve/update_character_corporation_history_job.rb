# frozen_string_literal: true

module Eve
  class UpdateCharacterCorporationHistoryJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(character_id)
      Eve::CharacterCorporationHistoryImporter.new(character_id).import
    end
  end
end
