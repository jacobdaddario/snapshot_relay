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
    end

    def take_snapshot
      self.class.instance_variable_get(:@_snapshot_source_methods).each do |method|
        SnapshotRelay::Snapshot.send("#{method}=", send(method))
      end
    end
  end
end