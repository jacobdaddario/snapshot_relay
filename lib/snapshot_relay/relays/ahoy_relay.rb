# frozen_string_literal: true

module SnapshotRelay
  module Relays
    class AhoyRelay
      MISSING_NAME = "You must define a name for the snapshot to use the Ahoy relay."
      MISSING_REQUEST = "You must snapshot the controller's `request` to use the Ahoy relay."

      def dispatch(snapshot)
        Ahoy::Tracker.new(request:).track event_name, snapshot
      end

      private

      def event_name
        @event_name ||= snapshot.delete(:snapshot_name)
        raise ArgumentError, MISSING_NAME if event_name.nil?

        @event_name
      end

      def request
        @request ||= snapshot.delete(:request)
        raise ArgumentError, MISSING_REQUEST if request.nil?

        @request
      end
    end
  end
end
