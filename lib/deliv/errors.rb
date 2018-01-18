module Deliv
  # Parent error for all errors raised in this gem
  class DelivError < StandardError
    attr_accessor :status_code

    def initialize(message = nil, status_code = 0)
      super(message)

      self.status_code = status_code
    end
  end

  class OfflineError < DelivError
    def initialize(message = nil, _status_code = 0)
      super(message, 0)
    end
  end

  class ApiError < DelivError; end
  class RequestError < ApiError; end
  class NotFoundError < ApiError; end
  class ServerError < ApiError; end
end
