require 'spec_helper'
require 'securerandom'

describe Deliv::Base do
  let(:test_data) do
    {
      ab: SecureRandom.hex,
      cd: SecureRandom.hex,
      ef: SecureRandom.hex,
      gh: SecureRandom.hex,
      ij: SecureRandom.hex,
      xYz: SecureRandom.hex
    }
  end

  class TestModel < described_class
    path '/test_models'

    attribute :ab, :cd, :ef, :gh, :ij, { x_yz: 'xYz' }
  end

  # the second class is to ensure our class/module vars do not get clobbered
  class AnotherTestModel < described_class
    path '/other_test_models'

    attribute :kl, :mn, :op, :qr, :st
  end

  context 'attributes' do
    let(:instance) do
      TestModel.new(test_data)
    end

    it 'assigns the path' do
      expect(instance.class.path).to eq('/test_models')
    end

    it 'assigns each standard attribute' do
      standard_test_data = test_data.reject { |k, _v| k == :xYz }

      standard_test_data.each do |key, val|
        expect(instance.send(key)).to eq(val)
      end
    end

    it 'assigns non-standard attributes (where data_key is provided)' do
      expect(instance.x_yz).to eq(test_data[:xYz])
    end
  end
end
