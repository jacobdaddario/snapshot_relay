# frozen_string_literal: true

module SnapshotRelay
  class Configuration
    def relays
      @relays ||= []
    end

    def add_relay(relay)
      @relays << relay
    end

    def remove_relay(relay)
      @relays.delete(relay)
    end
  end
end
