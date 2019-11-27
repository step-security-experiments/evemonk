# frozen_string_literal: true

require "rails_helper"

describe Eve::AncestriesImporterWorker do
  it { should be_a(Sidekiq::Worker) }

  describe "#perform" do
    before do
      #
      # LanguageMapper::LANGUAGES.each_key do |locale|
      #   Eve::AncestriesImporter.new(locale).import
      # end
      #
      LanguageMapper::LANGUAGES.each_key do |locale|
        expect(Eve::AncestriesImporter).to receive(:new).with(locale) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
