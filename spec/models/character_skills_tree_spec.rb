# frozen_string_literal: true

require "rails_helper"

describe CharacterSkillsTree do
  it { expect(described_class::SKILLS_CATEGORY_ID).to eq(16) }

  it { expect(described_class::PRIMARY_ATTRIBUTE_NAME).to eq("primaryAttribute") }

  it { expect(described_class::SECONDARY_ATTRIBUTE_NAME).to eq("secondaryAttribute") }

  let(:character) { instance_double(Character) }

  subject { described_class.new(character) }

  describe "#initialize" do
    its(:character) { should eq(character) }
  end

  describe "#preload" do
    before { expect(subject).to receive(:skill_category) }

    before { expect(subject).to receive(:skills_groups) }

    before { expect(subject).to receive(:skills_types) }

    before { expect(subject).to receive(:character_skills) }

    before { expect(subject).to receive(:character_skillqueues) }

    before { expect(subject).to receive(:certificates) }

    before { expect(subject).to receive(:dogma_attributes) }

    before { expect(subject).to receive(:type_dogma_attributes) }

    before { expect(subject).to receive(:more_dogma_attributes) }

    specify { expect(subject.preload).to eq(subject) }
  end

  describe "#skills_groups" do
    context "when @skills_groups is set" do
      let(:skills_groups) { double }

      before { subject.instance_variable_set(:@skills_groups, skills_groups) }

      specify { expect(subject.skills_groups).to eq(skills_groups) }
    end

    context "when @skills_groups is not set" do
      let(:category_id) { double }

      let(:skill_category) { instance_double(Eve::Category, category_id: category_id) }

      let(:skills_groups) { double }

      before { expect(subject).to receive(:skill_category).and_return(skill_category) }

      before do
        #
        # Eve::Group.published
        #           .where(category_id: skill_category.category_id)
        #           .order(:name_en)
        #           .to_a # => skills_groups
        #
        expect(Eve::Group).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:where).with(category_id: category_id) do
              double.tap do |b|
                expect(b).to receive(:order).with(:name_en) do
                  double.tap do |c|
                    expect(c).to receive(:to_a).and_return(skills_groups)
                  end
                end
              end
            end
          end
        end
      end

      specify { expect(subject.skills_groups).to eq(skills_groups) }

      specify { expect { subject.skills_groups }.to change { subject.instance_variable_get(:@skills_groups) }.from(nil).to(skills_groups) }
    end
  end

  # private methods

  describe "#skill_category" do
    context "when @skill_category is set" do
      let(:skill_category) { double }

      before { subject.instance_variable_set(:@skill_category, skill_category) }

      specify { expect(subject.send(:skill_category)).to eq(skill_category) }
    end

    context "when @skill_category is not set" do
      let(:skill_category) { double }

      before do
        #
        # Eve::Category.published
        #              .find_by!(category_id: SKILLS_CATEGORY_ID) # => skill_category
        #
        expect(Eve::Category).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(category_id: described_class::SKILLS_CATEGORY_ID)
                                           .and_return(skill_category)
          end
        end
      end

      specify { expect(subject.send(:skill_category)).to eq(skill_category) }

      specify { expect { subject.send(:skill_category) }.to change { subject.instance_variable_get(:@skill_category) }.from(nil).to(skill_category) }
    end
  end

  # def skill_category
  #   @skill_category ||= Eve::Category.published.find_by!(category_id: SKILLS_CATEGORY_ID)
  # end


  # def skills_count_in_group(group_id)
  #   skills_types.select { |type| type.group_id == group_id }.size
  # end
  #
  # def levels_trained_in_group(group_id)
  #   skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)
  #
  #   character_skills.select { |character_skill| skill_ids.include?(character_skill.skill_id) }.map(&:trained_skill_level).sum
  # end
  #
  # def total_levels_in_group(group_id)
  #   skills_types.select { |type| type.group_id == group_id }.size * 5
  # end
  #
  # def levels_in_training_queue(group_id)
  #   skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)
  #
  #   character_skillqueues.select { |skillqueue| skill_ids.include?(skillqueue.skill_id) }.size
  # end
  #
  # def current_skill_points_in_group(group_id)
  #   skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)
  #
  #   character_skills.select { |character_skill| skill_ids.include?(character_skill.skill_id) }.map(&:skillpoints_in_skill).sum
  # end
  #
  # def total_skill_points_in_group(group_id)
  #   0
  # end
  #
  # def certificates_claimed_in_group(group_id)
  #   0
  # end
  #
  # def total_certificates_in_group(group_id)
  #   certificates.select { |certificate| certificate.group_id == group_id }.size
  # end
  #
  # def skills_in_group(group_id)
  #   skills_types.select { |type| type.group_id == group_id }.sort_by(&:name_en)
  # end
  #
  # def training_rate_for_skill(skill_id)
  #   primary_dogma_attribute = dogma_attributes.find { |dogma_attribute| dogma_attribute.name == PRIMARY_ATTRIBUTE_NAME }
  #   primary_attribute_id = type_dogma_attributes.find { |tda| tda.type_id == skill_id && tda.attribute_id == primary_dogma_attribute.attribute_id }.value.to_i
  #   primary_attribute = more_dogma_attributes.find { |dogma_attribute| dogma_attribute.attribute_id == primary_attribute_id }
  #
  #   secondary_dogma_attribute = dogma_attributes.find { |dogma_attribute| dogma_attribute.name == SECONDARY_ATTRIBUTE_NAME }
  #   secondary_attribute_id = type_dogma_attributes.find { |tda| tda.type_id == skill_id && tda.attribute_id == secondary_dogma_attribute.attribute_id }.value.to_i
  #   secondary_attribute = more_dogma_attributes.find { |dogma_attribute| dogma_attribute.attribute_id == secondary_attribute_id }
  #
  #   primary = character.send(:"#{primary_attribute.name}")
  #   secondary = character.send(:"#{secondary_attribute.name}")
  #
  #   rate = EveOnline::Formulas::TrainingRate.new(primary, secondary).rate
  #
  #   format("%0.2f", rate)
  # end
  #
  # private
  #
  # def skill_category
  #   @skill_category ||= Eve::Category.published.find_by!(category_id: SKILLS_CATEGORY_ID)
  # end
  #
  # def skills_types
  #   @skills_types ||= Eve::Type.published.where(group_id: skills_groups.map(&:group_id).sort.uniq).to_a
  # end
  #
  # def certificates
  #   @certificates ||= Eve::Certificate.all.to_a
  # end
  #
  # def character_skills
  #   @character_skills ||= character.character_skills.to_a
  # end
  #
  # def character_skillqueues
  #   @character_skillqueues ||= character.skillqueues.order(:queue_position).where("skillqueues.finish_date > :now", now: Time.zone.now).to_a
  # end
  #
  # def dogma_attributes
  #   @dogma_attributes ||= Eve::DogmaAttribute.published.where(name: [PRIMARY_ATTRIBUTE_NAME, SECONDARY_ATTRIBUTE_NAME]).to_a
  # end
  #
  # def type_dogma_attributes
  #   @type_dogma_attributes ||= Eve::TypeDogmaAttribute.where(attribute_id: dogma_attributes.map(&:attribute_id).sort.uniq).to_a
  # end
  #
  # def more_dogma_attributes
  #   @more_dogma_attributes ||= Eve::DogmaAttribute.published.where(attribute_id: type_dogma_attributes.map(&:value).map(&:to_i).sort.uniq).to_a
  # end
end
