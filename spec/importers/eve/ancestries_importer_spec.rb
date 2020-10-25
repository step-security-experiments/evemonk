# frozen_string_literal: true

require "rails_helper"

describe Eve::AncestriesImporter do
  describe "#initialize" do
    context "without locale" do
      its(:locale) { should eq(:en) }
    end

    context "with locale" do
      let(:locale) { :ru }

      subject { described_class.new(locale) }

      its(:locale) { should eq(:ru) }
    end
  end

  describe "#import!" do
    let(:ancestry_id) { double }

    let(:as_json) { double }

    let(:ancestry) { instance_double(EveOnline::ESI::Models::Ancestry, ancestry_id: ancestry_id, as_json: as_json) }

    let(:esi) { instance_double(EveOnline::ESI::UniverseAncestries, ancestries: [ancestry]) }

    before { expect(EveOnline::ESI::UniverseAncestries).to receive(:new).with(language: "en-us").and_return(esi) }

    let(:eve_ancestry) { instance_double(Eve::Ancestry) }

    before { expect(Eve::Ancestry).to receive(:find_or_initialize_by).with(ancestry_id: ancestry_id).and_return(eve_ancestry) }

    before { expect(eve_ancestry).to receive(:update!).with(as_json) }

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseAncestries) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseAncestries) }

      before { expect(EveOnline::ESI::UniverseAncestries).to receive(:new).with(language: "en-us").and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
