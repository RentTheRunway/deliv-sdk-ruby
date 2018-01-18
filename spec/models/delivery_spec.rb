require 'spec_helper'
require 'securerandom'

describe Deliv::Delivery do
  let(:id) { SecureRandom.hex }

  let(:test_data) do
    {
      'id' => id,
      'tracking_code' => SecureRandom.hex,
      'order_reference' => SecureRandom.hex,
      'status' => SecureRandom.hex
    }
  end

  let(:typhoeus_response) do
    Typhoeus::Response.new({
      code: 200,
      return_code: :ok,
      body: test_data.to_json
    })
  end

  let(:failed_typhoeus_response) do
    Typhoeus::Response.new({
      code: 404,
      return_code: :not_found
    })
  end

  context '.find' do
    it do
      expect(Typhoeus).to \
        receive(:get)
        .with(%r(#{described_class.path}\/#{id}), anything)
        .and_return(typhoeus_response)

      described_class.find(id)
    end

    it 'handles errors' do
      allow(Typhoeus).to \
        receive(:get)
        .and_return(failed_typhoeus_response)

      expect {
        described_class.find(id)
      }.to raise_error(Deliv::NotFoundError)
    end
  end

  # you do not have to do this for all models.
  # doing it once should be good enough
  context '(accessors)' do
    before do
      expect(Typhoeus).to \
        receive(:get)
        .and_return(typhoeus_response)
    end

    let(:instance) { described_class.find(id) }

    it 'creates accessors correctly: id' do
      expect(instance.id).to eq(test_data['id'])
    end

    it 'creates accessors correctly: tracking_code' do
      expect(instance.tracking_code).to eq(test_data['tracking_code'])
    end

    it 'creates accessors correctly: order_reference' do
      expect(instance.order_reference).to eq(test_data['order_reference'])
    end

    it 'creates accessors correctly: status' do
      expect(instance.status).to eq(test_data['status'])
    end
  end

  context '.from_order_reference' do
    let(:order_reference) { SecureRandom.hex }

    it do
      options_constraint =
        hash_including(params: { order_reference: order_reference })

      expect(Typhoeus).to \
        receive(:get)
        .with(anything, options_constraint)
        .and_return(typhoeus_response)

      described_class.from_order_reference(order_reference)
    end
  end
end
