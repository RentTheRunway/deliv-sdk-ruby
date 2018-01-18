require 'spec_helper'
require 'securerandom'

describe Deliv do
  it 'has a version number' do
    expect(Deliv::VERSION).not_to be nil
  end

  describe 'Configuration' do
    [
      :host,
      :version,
      :api_key
    ].each do |config_setting|
      let(config_setting) { SecureRandom.hex }

      before do
        described_class.configure do |configuration|
          configuration.send("#{config_setting}=", send(config_setting))
        end
      end

      it "allows the configuration setting '#{config_setting}' to be set" do
        expect(described_class.configuration.send(config_setting))
          .to eq send(config_setting)
      end
    end
  end
end
