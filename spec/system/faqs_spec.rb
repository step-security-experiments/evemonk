# frozen_string_literal: true

require "rails_helper"

RSpec.describe "FAQ features" do
  before { driven_by(:selenium_chrome_headless) }

  describe "should render page" do
    it "when user not logged in" do
      visit faq_path
    end

    it "when user is logged in" do
      user = create(:user)

      sign_in user

      visit faq_path
    end
  end
end
