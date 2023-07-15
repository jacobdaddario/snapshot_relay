# frozen_string_literal: true

require "logger"

module SnapshotRelay
  module Relays
    class LoggerRelay
      class << self
        def dispatch(snapshot)
          logger.info "SnapshotRelay diagnostics: #{snapshot}"
        end

        private

        def logger
          @logger ||= Logger.new($stdout)
        end
      end
    end
  end
end
