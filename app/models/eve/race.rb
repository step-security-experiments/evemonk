# frozen_string_literal: true

module Eve
  class Race < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name, :description

    # TODO: FIXME
    # belongs_to :alliance,
    #   primary_key: "alliance_id",
    #   optional: true

    has_many :bloodlines,
      primary_key: "race_id"

    has_many :stations,
      primary_key: "race_id"
  end
end
