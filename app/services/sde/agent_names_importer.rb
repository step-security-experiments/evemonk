# frozen_string_literal: true

module Sde
  class AgentNamesImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load(File.read(file))

      Eve::Agent.find_each do |eve_agent|
        entry = entries.find { |hash| hash["itemID"] == eve_agent.agent_id }

        eve_agent.update!(name: entry["itemName"])
      end
    end
  end
end
