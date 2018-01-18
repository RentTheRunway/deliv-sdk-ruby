# Deliv

Deliv is a courier service.
This gem was developed to handle our read-only use cases, but feel free to submit PRs to add more functionality!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'deliv-sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deliv-sdk

## Usage

In an initialization script:
``` Ruby
Deliv.configure do |config|
  config.host = 'https://api-sandbox.deliv.co' # no trailing slash
  config.version = 'v2'                        # use v2 as of 2018-01-24
  config.api_key = '<your api key>'            # contact Deliv for this
end
```

Where ever you need it,
``` Ruby
require 'deliv-sdk'

id_or_tracking_code = '...'
delivery = Deliv::Delivery.find(id_or_tracking_code)

# for reference: http://docs.deliv.co/v2/#deliveries
delivery.estimated_delivery_at
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RentTheRunway/deliv-sdk.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

