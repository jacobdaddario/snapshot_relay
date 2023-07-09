# frozen_string_literal: true

module SnapshotRelay
  class SnapshotRelayError < StandardError; end

  class EmptySnapshotError < StandardError
    ERROR_MESSAGE = "You must define at least one snapshot_writer method in your class"

    def initialize(msg = ERROR_MESSAGE)
      super
    end
  end
end
