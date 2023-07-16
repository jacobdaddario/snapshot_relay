# frozen_string_literal: true

require "snapshot_relay/relays/logger_relay"

RSpec.describe SnapshotRelay::Relays::LoggerRelay do
  describe ".dispatch" do
    subject { described_class.dispatch(snapshot) }

    let(:snapshot) { {foo: :bar, bat: [1, 2, 3]} }
    let(:logger) { instance_double(Logger) }

    before do
      allow(Logger).to receive(:new).and_return(logger)
      allow(logger).to receive(:info)
    end

    it "logs to $stdout" do
      subject

      expect(logger).to have_received(:info).with("SnapshotRelay diagnostics: #{snapshot}")
    end
  end
end
