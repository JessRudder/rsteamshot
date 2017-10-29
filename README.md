# Rsteamshot

[![Build Status](https://travis-ci.org/cheshire137/rsteamshot.svg?branch=master)](https://travis-ci.org/cheshire137/rsteamshot)

Rsteamshot is a Ruby gem for getting the latest screenshots a user has uploaded to their Steam profile, as well as the latest screenshots uploaded for a particular game.

[View source on GitHub](https://github.com/cheshire137/rsteamshot)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rsteamshot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rsteamshot

## Usage

```ruby
# Get screenshots uploaded by a Steam user:
steam_user_name = 'cheshire137'
user = Rsteamshot::User.new(steam_user_name)
order = 'newestfirst' # also: score, oldestfirst
screenshots = user.screenshots(order: order, per_page: 10)
screenshots += user.screenshots(order: order, page: 2, per_page: 10)

# Find a Steam app by name:
apps_path = 'apps-list.json'
Rsteamshot::App.download_apps_list(apps_path)
apps = Rsteamshot::App.search('witcher 3', apps_path)
app = apps.first

# Initialize an app directly if you know its ID:
app_id = '377160'
app = Rsteamshot::App.new(app_id)

# Get screenshots uploaded for a Steam game:
order = 'mostrecent' # also: toprated, trendday, trendweek, trendthreemonths, trendsixmonths,
                     # trendyear
screenshots = app.screenshots(order: order, per_page: 10)
screenshots += app.screenshots(order: order, page: 2, per_page: 10)

# Data available for each screenshot:
screenshots.each do |screenshot|
  puts screenshot.title
  puts screenshot.details_url
  puts screenshot.full_size_url
  puts screenshot.medium_url
  puts screenshot.user_name
  puts screenshot.user_url
  puts screenshot.date
  puts screenshot.file_size
  puts screenshot.width
  puts screenshot.height

  # Utility methods:
  puts screenshot.to_h
  puts screenshot.to_json
end
```

## Development

After checking out [the repo](https://github.com/cheshire137/rsteamshot), run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

[Bug reports](https://github.com/cheshire137/rsteamshot/issues) and pull requests are welcome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
