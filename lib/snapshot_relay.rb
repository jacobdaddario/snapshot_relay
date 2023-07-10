# frozen_string_literal: true

require "snapshot_relay/version"

require "snapshot_relay/errors"
require "snapshot_relay/configuration"
require "snapshot_relay/snapshot"
require "snapshot_relay/dsl"

require "forwardable"

module SnapshotRelay
  class << self
    def configuration
      @configuration ||= Configuration.new
    end
    delegate :relays, to: :configuration

    def configure
      yield(configuration)
    end
  end
end
