# frozen_string_literal: true

RSpec.describe SnapshotRelay::Snapshot do
  after { described_class.reset }

  let(:attribute_whitelist) { [:foo, :bar] }
  let(:status) { :foo }
  let(:snapshot_name) { "Foo" }
  let(:foo_value) { [1, 2, 3] }
  let(:bar_value) { {a: 1, b: 2, c: 3} }

  before do
    described_class.snapshot_current_attribute_whitelist = attribute_whitelist

    described_class.status = status
    described_class.snapshot_name = snapshot_name
    described_class.foo = foo_value
    described_class.bar = bar_value
  end

  describe ".snapshot_current_attribute_whitelist" do
    it "returns the value of the attribute" do
      expect(described_class.snapshot_current_attribute_whitelist).to eq(attribute_whitelist)
    end
  end

  describe ".status" do
    it "returns the value of the attribute" do
      expect(described_class.status).to eq(status)
    end
  end

  describe ".snapshot_name" do
    it "returns the value of the attribute" do
      expect(described_class.snapshot_name).to eq(snapshot_name)
    end
  end

  describe ".render_snapshot" do
    it "returns a hash of whitelisted attributes" do
      expect(described_class.render_snapshot).to eq({foo: foo_value, bar: bar_value, status: status, snapshot_name: "Foo"})
    end
  end

  describe ".mark_failure" do
    it "sets the status to failure" do
      described_class.mark_failure

      expect(described_class.status).to eq(:failure)
    end
  end

  describe ".mark_success" do
    it "sets the status to success" do
      described_class.mark_success

      expect(described_class.status).to eq(:success)
    end
  end

  describe "#method_missing" do
    context "when the method ends with =" do
      it "defines a new attribute" do
        expect(described_class).not_to respond_to(:baz)
        described_class.baz = "baz"

        expect(described_class).to respond_to(:baz)
      end

      it "sets the value of the attribute" do
        described_class.baz = "baz"

        expect(described_class.baz).to eq("baz")
      end
    end

    context "when the method does not end with =" do
      it "raises a NoMethodError" do
        expect { described_class.boom }.to raise_error(NoMethodError)
      end
    end
  end

  describe "#respond_to_missing?" do
    subject { described_class.respond_to?(method_name) }

    context "when the method ends with =" do
      let(:method_name) { :buzz= }

      it { is_expected.to be true }
    end

    context "when the method does not end with =" do
      let(:method_name) { :buzz }

      it { is_expected.to be false }
    end
  end
end
