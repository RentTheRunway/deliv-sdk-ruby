require_relative 'base'

module Deliv
  # http://docs.deliv.co/v2/#deliveries
  class Delivery < Base
    extend ApiMethods

    path 'deliveries'

    attribute \
      :id, # (string) The identifier of the delivery (expressed as a UUID)
      :object, # (string) The object type (‘delivery’)
      :tracking_code, # (string) The unique tracking code the customer uses to track the delivery
      :order_reference, # (string) Your internal order number, for reconciling
      :alt_id_1, # (string) Additional internal order number, for reconciling
      :alt_id_2, # (string) Additional internal order number, for reconciling
      :status, # (string) The status of the delivery
      :ready_by, # (timestamp) The time when the delivery can be picked up
      :delivery_window, # (delivery window) The chosen delivery window from your delivery estimate
      :customer, # (customer) The customer the packages will be delivered to
      :customer_signature_type, # (string) The signature requirements for the delivery
      :store, # (store) The store the packages will be picked up from
      :store_signature_required, # (boolean) A flag if capturing a signature at pickup is required
      :origin_comments, # (string) Special instructions for the driver during pickup (i.e. what counter to pickup from)
      :destination_comments, # (string) Special instructions for the driver during delivery (i.e. gate codes, etc)
      :age_required, # (int) Minimum age of recipient (i.e. 21 for alcohol related deliveries)
      :packages, # (array) A set of one or more packages to be delivered
      :driver, # (driver) The driver making the delivery
      :shipping_label_url, # (string) Requires additional configurations by account manager. Example string: https://platform.deliv.co/orders/#{tracking_code}/label.pdf
      :estimated_delivery_at, # (timestamp) Estimated time of driver arrival at destination
      :delivered_at, # (timestamp) Actual time of driver arrival at destination
      :webhook_url, # (string) A URL where you can receive updates on this delivery
      :exception, # (exception) The exception that lead to the delivery’s cancel or return
      :being_returned, # (boolean) Whether or not the delivery is being returned
      :return_signature, # (return signature) The return signature, if captured and the delivery has been returned
      :staging_location_name, # (string) The location that the delivery will be staged (bin number, for example)
      :staged_at # (timestamp) Generated timestamp when staging_location_name was created or updated

    class << self
      # returns an array (although likely only 0 or 1 entries) or deliveries
      # which have an order_reference equal to that passed to the method
      def from_order_reference(order_reference)
        list(order_reference: order_reference)
      end
    end
  end
end
