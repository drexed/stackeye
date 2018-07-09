# Stackeye

#### What is it?
Stackeye is small and lightweight metrics monitoring system.
It's meant for projects where longterm and highly detailed metrics
is not a priority (p.s. thats what Scout and New Relic are for).

#### What are the design decisions?
One of the main design aspects of this project was to have as little
dependencies as possible (currently just Sinatra). All metric commands
are executed locally and all data is stored locally in JSON files.

#### What does the future hold?
This project will continue to grow overtime but I would **love some help
from the community** to really make it blossom into a great project. The
following is a list of future must/nice to have:

* Alerts
  * Email
  * SMS
* Metrics
  * Ruby
  * Rails
  * SQLite
  * PostgreSQL
  * Redis

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stackeye'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stackeye

## Usage

#### Standalone Sinatra app
```ruby
ruby app.rb

# crontab
*/5 * * * * /bin/bash -l -c 'cd /path/to/project && Stackeye::Metrics::All.set >> /dev/null'
0 0 * * * /bin/bash -l -c 'cd /path/to/project && Stackeye::Tools::Database.truncate >> /dev/null'
```

#### Mounted Rails app
```ruby
# Run initializer generator:
rails generate stackeye:install

# config/routes.rb
mount Stackeye::Application, at: '/stackeye'

# The following could be used if you are using
# the whenever gem to manage your crons.

# config/schedule.rb
every 5.minutes do
  runner 'Stackeye::Metrics::All.set'
end

every :day, at: '12:00 am' do
  runner 'Stackeye::Tools::Database.truncate'
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/drexed/stackeye. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Stackeye project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/drexed/stackeye/blob/master/CODE_OF_CONDUCT.md).
