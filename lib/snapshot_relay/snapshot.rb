# frozen_string_literal: true

require "active_support/current_attributes"
require "active_support/isolated_execution_state"
require "active_support/code_generator"

module SnapshotRelay
  class Snapshot < ActiveSupport::CurrentAttributes
    # These are required attributes for usage of the library
    attribute :snapshot_current_attribute_whitelist, :status, :snapshot_name

    def self.render_snapshot
      attributes.slice(*snapshot_current_attribute_whitelist, :status, :snapshot_name)
    end

    def self.mark_failure
      self.status = :failure
    end

    def self.mark_success
      self.status = :success
    end

    def method_missing(method, *args)
      if method.end_with?("=")
        attribute_name = method[0..-2]

        self.class.attribute attribute_name
        send(method, *args)
      end
    end

    def respond_to_missing?(method, include_private = false)
      method.end_with?("=") || super
    end
  end
end
