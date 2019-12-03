# frozen_string_literal: true

require "rails_helper"

describe CharacterSkillqueueImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  # context "when character found" do
  #   let(:access_token) { double }
  #
  #   let(:character) { instance_double(Character, access_token: access_token) }
  #
  #   before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_return(character) }
  #
  #   before { expect(subject).to receive(:refresh_character_access_token) }
  #
  #   let(:json) { double }
  #
  #   let(:skill) { instance_double(EveOnline::ESI::Models::SkillQueueEntry, as_json: json) }
  #
  #   let(:esi) do
  #     instance_double(EveOnline::ESI::CharacterSkillQueue,
  #       skills: [skill])
  #   end
  #
  #   before { expect(EveOnline::ESI::CharacterSkillQueue).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }
  #
  #   before do
  #     #
  #     # character.skillqueues.destroy_all
  #     #
  #     expect(character).to receive(:skillqueues) do
  #       double.tap do |a|
  #         expect(a).to receive(:destroy_all)
  #       end
  #     end
  #   end
  #
  #   before do
  #     #
  #     # character.skillqueues.create!(skill.as_json)
  #     #
  #     expect(character).to receive(:skillqueues) do
  #       double.tap do |a|
  #         expect(a).to receive(:create!).with(json)
  #       end
  #     end
  #   end
  #
  #   specify { expect { subject.import }.not_to raise_error }
  # end
end
