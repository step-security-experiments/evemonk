# frozen_string_literal: true

require "rails_helper"

describe LanguageMapper do
  specify do
    expect(described_class::LANGUAGES).to eq(:en => "en-us",
                                             :de => "de",
                                             :fr => "fr",
                                             :ja => "ja",
                                             :ru => "ru",
                                             :zh => "zh",
                                             :ko => "ko")
  end
end
