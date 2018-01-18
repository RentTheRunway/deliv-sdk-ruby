require 'deliv/configuration'
require 'deliv/errors'
require 'deliv/json_provider'
require 'deliv/models'
require 'deliv/version'

# Root module for all Deliv SDK code
module Deliv
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def json_provider=(provider)
      @json_provider = provider
    end

    def json_provider
      @json_provider
    end
  end

  self.json_provider = DefaultJsonProvider
end
