require_relative 'api_methods'

module Deliv
  class Base
    extend ApiMethods

    def initialize(data = {})
      self._data = data
    end

    protected

    attr_accessor :_data

    class << self
      # accepts either a hash of { method: data_key } pairs, or an array of
      # methods whose data_keys are derived from the method name.
      # Deliv uses snake case in its JSON
      # === Examples
      #   attribute :id, :tracking_code, :order_reference
      #   attribute id: 'ID', tracking_code: 'trackingCode'
      # you could even combine them
      #   attribute :id, :tracking_code, { order_reference: 'orderReference' }
      def attribute(*attrs)
        Array(attrs).each do |attribute|
          if attribute.is_a?(Hash)
            attribute.each { |m, k| define_attribute(m, k) }
          else
            define_attribute(attribute)
          end
        end
      end

      private

      def define_attribute(method, data_key = nil)
        key = (data_key || method).to_sym

        define_method method do
          _data[key]
        end

        define_method "#{method}=" do |val|
          _data[key] = val
        end
      end
    end
  end
end
