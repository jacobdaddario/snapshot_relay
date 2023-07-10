# frozen_string_literal: true

module SnapshotRelay
  class Configuration
    def relays
      @relays ||= []
    end

    def add_relays(*relays)
      @relays.concat(relay)
    end

    def remove_relays(*relays)
      relays.each do |relay|
        @relays.delete(relay)
      end
    end
  end
end
