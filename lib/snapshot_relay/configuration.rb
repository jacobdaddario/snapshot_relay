# frozen_string_literal: true

module SnapshotRelay
  class Configuration
    def relays
      @relays ||= []
    end

    def add_relays(*target_relays)
      relays.concat(target_relays)
    end

    def remove_relays(*target_relays)
      target_relays.each do |relay|
        relays.delete(relay)
      end
    end
  end
end
