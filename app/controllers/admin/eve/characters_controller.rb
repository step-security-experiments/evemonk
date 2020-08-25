# frozen_string_literal: true

module Admin
  module Eve
    class CharactersController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
