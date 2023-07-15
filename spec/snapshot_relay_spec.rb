# frozen_string_literal: true

RSpec.describe SnapshotRelay do
  it "has a version number" do
    expect(SnapshotRelay::VERSION).not_to be_nil
  end

  describe ".configuration" do
    after { described_class.instance_variable_set(:@configuration, nil) }

    it "returns a Configuration instance" do
      expect(described_class.configuration).to be_a(SnapshotRelay::Configuration)
    end

    it "sets the value of @configuration" do
      described_class.configuration

      expect(described_class.instance_variable_get(:@configuration)).to be_a(SnapshotRelay::Configuration)
    end

    context "when a configuration has already been set" do
      let(:configuration) { SnapshotRelay::Configuration.new }

      before do
        described_class.instance_variable_set(:@configuration, configuration)
      end

      it "returns the same Configuration instance" do
        expect(described_class.configuration).to eq(configuration)
      end
    end
  end

  describe ".relays" do
    let(:configuration) { SnapshotRelay::Configuration.new }
    let(:relays) { [:relay_1, :relay_2] }

    before do
      configuration.add_relays(*relays)
      described_class.instance_variable_set(:@configuration, configuration)
    end

    after { described_class.instance_variable_set(:@configuration, nil) }

    it "returns the value on the configuration object" do
      expect(described_class.relays).to eq(relays)
    end
  end

  describe ".configure" do
    let(:configuration) { SnapshotRelay::Configuration.new }

    before do
      described_class.instance_variable_set(:@configuration, configuration)
    end

    after { described_class.instance_variable_set(:@configuration, nil) }

    it "yields the configuration object" do
      expect { |block| described_class.configure(&block) }.to yield_with_args(configuration)
    end
  end
end
