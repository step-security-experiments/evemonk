# frozen_string_literal: true

require "rails_helper"

describe StandingsController do
  describe "routing" do
    it "should route GET /characters/90729314/standings to standings#index" do
      expect(get: "/characters/90729314/standings").to route_to(
        controller: "standings",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
