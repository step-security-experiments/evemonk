# frozen_string_literal: true

class BlueprintsListsController < ApplicationController
  def index
    @character = current_user.characters
      .find_by!(character_id: params[:character_id])

    @form = CharacterStandingsFilterForm.new(params[:filter])

    @character_blueprints = CharacterBlueprints.new(@character, params).query

    render layout: false
  end
end
