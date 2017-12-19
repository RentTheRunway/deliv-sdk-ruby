module Deliv
  # Parent error for all errors raised in this gem
  class DelivError < StandardError
    attr_accessor :status_code
  end
end
