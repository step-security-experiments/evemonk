# frozen_string_literal: true

require "rails_helper"

describe Eve::AgentDashboard do
  it { should be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:agent) { build(:eve_agent, name: "Pomik Haromi") }

    specify { expect(subject.display_resource(agent)).to eq("Pomik Haromi") }
  end
end
