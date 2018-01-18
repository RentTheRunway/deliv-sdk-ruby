require 'typhoeus'

require_relative '../errors'

# for API documentation:
# http://docs.deliv.co/v2/

module Deliv
  module ApiMethods
    # the path at which the resource can be found
    # === Example
    # class Resource
    #   path '/resources'
    # end
    def path(p = nil)
      @path = p unless p.nil?

      @path
    end

    # fetch a list of resources, optionally matching the search criteria
    def list(params = {})
      response = get(nil, params)

      resources_data = Deliv.json_provider.read(response.body)

      from_array(resources_data)
    end

    # fetch the resource corresponding to the passed resource_id
    # optionally matching the search criteria
    def find(resource_id, params = {})
      response = get(resource_id, params)

      resource_data = Deliv.json_provider.read(response.body)

      new(resource_data)
    end

    protected

    # take an array of Hash data and convert it into an array of model instances
    def from_array(array)
      return [] if array.nil?

      array.map(&method(:new))
    end

    def ensure_success(response)
      return if response.code.between?(200, 299)

      case response.code
      when 0
        raise OfflineError
      when 404
        raise NotFoundError.new(response.body, response.code)
      when 400..499
        raise RequestError.new(response.body, response.code)
      when 500..599
        raise ServerError.new(response.body, response.code)
      else
        raise ApiError.new(response.body, response.code)
      end
    end

    def get(resource_id = nil, params = {})
      url = api_url(resource_id)

      Typhoeus.get(url, {
        verbose: debug_mode?,
        params: params,
        headers: standard_headers
      }).tap do |response|
        puts response.body if debug_mode?

        ensure_success(response)
      end
    end

    private

    def debug_mode?
      ENV['DELIV_DEBUG'] == 'true'
    end

    def api_url(resource_id = nil)
      url = "#{Deliv.configuration.host}/#{Deliv.configuration.version}/#{path}"

      return url if resource_id.nil?

      url << "/#{resource_id}"
    end

    def standard_headers
      {
        'Api-Key' => Deliv.configuration.api_key,
        'User-Agent' => "Deliv SDK (#{ENV['RACK_ENV']})"
      }
    end
  end
end
