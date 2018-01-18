require 'json'

module Deliv
  # a simple abstraction of a JSON serialization class to allow clients to use
  # whichever one they prefer
  class JsonProvider
    class << self
      def read(_json)
        raise NotImplementedError, 'Implement using your favorite JSON provider'
      end

      def write(_hash)
        raise NotImplementedError, 'Implement using your favorite JSON provider'
      end
    end
  end

  # an implementaiton of the JsonProvider class which uses the standard JSON
  # library
  class DefaultJsonProvider < JsonProvider
    class << self
      def read(json)
        JSON.parse(json, symbolize_names: true)
      end

      def write(hash)
        JSON.generate(hash)
      end
    end
  end

  # # We recommend using Oj as your JSON prodivder. To use, copy this somewhere
  # # in your application
  # class OjJsonProvider < Godmother::JsonProvider
  #   class << self
  #     def read(json)
  #       Oj.load(json, symbol_keys: true)
  #     end

  #     def write(hash)
  #       Oj.dump(hash)
  #     end
  #   end
  # end

  # Devil.json_provider = OjJsonProvider
end
