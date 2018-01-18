require 'simplecov'
SimpleCov.start

# pulls in the *.rb file corresponding to the current test being run
# i.e., delivery_spec.rb -> delivery.rb
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'deliv-sdk'
