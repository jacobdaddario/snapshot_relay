# frozen_string_literal: true

RSpec.describe SnapshotRelay::Configuration do
  subject { described_class.new }

  let(:relays) { [:relay_1, :relay_2] }

  before { subject.instance_variable_set(:@relays, relays) }

  describe "#relays" do
    it "returns the value of @relays" do
      expect(subject.relays).to eq(relays)
    end

    context "when @relays is nil" do
      before { subject.instance_variable_set(:@relays, nil) }

      it "returns an empty array" do
        expect(subject.relays).to eq([])
      end

      it "sets the value of @relays to an empty array" do
        subject.relays

        expect(subject.instance_variable_get(:@relays)).to eq([])
      end
    end
  end

  describe "#add_relays" do
    it "adds the relays to the value of @relays" do
      subject.add_relays(:relay_3, :relay_4)

      expect(subject.relays).to eq([:relay_1, :relay_2, :relay_3, :relay_4])
    end
  end

  describe "#remove_relays" do
    it "removes the relays from the value of @relays" do
      subject.remove_relays(:relay_1, :relay_2)

      expect(subject.relays).to eq([])
    end
  end
end
