require 'spec_helper'

describe Deliv::DelivError do
  let(:msg) { SecureRandom.hex }
  let(:code) { SecureRandom.random_number(100_000) }

  context '.initialize' do
    let(:instance) { described_class.new(msg, code) }

    it do
      expect(instance.message).to eq(msg)
    end

    it do
      expect(instance.status_code).to eq(code)
    end
  end
end

describe Deliv::OfflineError do
  let(:msg) { SecureRandom.hex }
  let(:code) { SecureRandom.random_number(100_000) }

  context '.initialize' do
    let(:instance) { described_class.new(msg, code) }

    it do
      expect(instance.message).to eq(msg)
    end

    it do
      expect(instance.status_code).to eq(0)
    end
  end
end
