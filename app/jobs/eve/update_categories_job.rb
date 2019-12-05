# frozen_string_literal: true

module Eve
  class UpdateCategoriesJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError

    def perform
      Eve::CategoriesImporter.new.import
    end
  end
end
