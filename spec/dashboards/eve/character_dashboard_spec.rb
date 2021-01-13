# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterDashboard do
  it { should be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:character) { build(:eve_character, name: "Johnn Dillinger") }

    specify { expect(subject.display_resource(character)).to eq("Johnn Dillinger") }
  end
end
