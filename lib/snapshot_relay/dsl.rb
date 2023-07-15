# frozen_string_literal: true

require "active_support/concern"

module SnapshotRelay
  module DSL
    extend ActiveSupport::Concern

    class_methods do
      def snapshot_reader(*attrs)
        instance_variable_set(:@_snapshot_attribute_whitelist, attrs)
      end

      def snapshot_writer(*attrs)
        instance_variable_set(:@_snapshot_source_methods, attrs)
      end

      def snapshot_accessor(*attrs)
        snapshot_reader(*attrs)
        snapshot_writer(*attrs)
      end

      def snapshot_name(name)
        instance_variable_set(:@_snapshot_name, name)
      end

      def snapshot_and_raise(e)
        Snapshot.mark_error
        Snapshot.render_snapshot

        raise e
      end
    end

    def add_to_snapshot
      raise EmptySnapshotError if self.class.instance_variable_get(:@_snapshot_source_methods).nil?

      self.class.instance_variable_get(:@_snapshot_source_methods).each do |method|
        Snapshot.send("#{method}=", send(method))
      end
    end

    def relay_snapshot(with_status: nil)
      Snapshot.status = with_status unless with_status.nil?

      Snapshot.snapshot_current_attribute_whitelist = self.class.instance_variable_get(:@_snapshot_attribute_whitelist)
      Snapshot.snapshot_name = self.class.instance_variable_get(:@_snapshot_name) if self.class.instance_variable_get(:@_snapshot_name)

      SnapshotRelay.relays.each do |relay|
        relay.dispatch(Snapshot.render_snapshot)
      end
    end
  end
end
