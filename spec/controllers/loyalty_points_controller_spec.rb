# frozen_string_literal: true

require "rails_helper"

describe LoyaltyPointsController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

  describe "#index" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      let(:character) { instance_double(Character) }

      before do
        #
        # subject.current_user
        #        .characters
        #        .includes(:race, :bloodline, :ancestry, :faction, :alliance, :corporation)
        #        .find_by!(character_id: params[:character_id])
        #        .decorate
        #
        expect(subject).to receive(:current_user) do
          double.tap do |a|
            expect(a).to receive(:characters) do
              double.tap do |b|
                expect(b).to receive(:includes).with(:race, :bloodline, :ancestry, :faction, :alliance, :corporation) do
                  double.tap do |c|
                    expect(c).to receive(:find_by!).with(character_id: "1") do
                      double.tap do |d|
                        expect(d).to receive(:decorate).and_return(character)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end

      before do
        #
        # character.loyalty_points.includes(:corporation)
        #
        expect(character).to receive(:loyalty_points) do
          double.tap do |a|
            expect(a).to receive(:includes).with(:corporation)
          end
        end
      end

      before { get :index, params: {character_id: "1"} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when user not signed in" do
      before { get :index, params: {character_id: "1"} }

      it { should redirect_to(new_user_session_path) }
    end
  end
end
