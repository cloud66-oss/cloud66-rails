# Cloud66
This gem provides various integrations with Cloud 66.

## Usage
### Queue Metrics Endpoint
By default, this gem will expose a metrics endpoint in your application at `/cloud66/metrics/queue`, which is only accessible through internal requests to `127.0.0.1` or `::1`.

This endpoint will detect which supported queue frameworks your application uses, and then expose some useful metrics:
- How many jobs are waiting in a given queue
- How many jobs are currently being processed in a given queue

The supported queue frameworks are:
- [Sidekiq (7+)](https://github.com/sidekiq/sidekiq)
- [Resque](https://github.com/resque/resque)
- [Delayed Job](https://github.com/collectiveidea/delayed_job) (via the [ActiveRecord backend](https://github.com/collectiveidea/delayed_job_active_record))

If you are using the Rails `ActionDispatch::HostAuthorization` middleware (through e.g. `config.hosts`), we suggest [excluding the metrics endpoint](https://guides.rubyonrails.org/configuring.html#actiondispatch-hostauthorization) from host authorization using `config.host_authorization.exclude`.

### Configuration
You can configure this gem by creating a file in your Rails initializers (e.g. `config/initializers/cloud66.rb`) and adding the following (values shown are the defaults):
```ruby
Cloud66.configure do |config|
  config.engine_automount = true
  config.engine_automount_endpoint = "/cloud66"
end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "cloud66"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install cloud66
```

## License
The gem is available as open source under the terms of the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).
