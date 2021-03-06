# Rsteamshot

[![Build Status](https://travis-ci.org/cheshire137/rsteamshot.svg?branch=master)](https://travis-ci.org/cheshire137/rsteamshot)

Rsteamshot is a Ruby gem for getting screenshots a user has uploaded to their Steam profile, as well as screenshots uploaded for a particular game. You can find the newest screenshots as well as the most popular screenshots. Screenshots can be paginated.

There's no Steam API that I know of that provides this screenshot data, so this gem works by using [Mechanize](https://github.com/sparklemotion/mechanize) to do web scraping on [steamcommunity.com](http://steamcommunity.com/).

[View source on GitHub](https://github.com/cheshire137/rsteamshot) | [View docs on RubyDoc](http://www.rubydoc.info/gems/rsteamshot/) | [View gem on RubyGems](https://rubygems.org/gems/rsteamshot)

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
# Specify where the latest list of apps from Steam should be downloaded as a JSON file, and
# referenced when looking up app IDs:
Rsteamshot.configure do |config|
  config.apps_list_path = 'apps-list.json'
end

# Get screenshots uploaded by a Steam user:
steam_user_name = 'cheshire137'
user = Rsteamshot::User.new(steam_user_name)
user.per_page = 10
order = 'newestfirst' # also: score, oldestfirst
screenshots = user.screenshots(order: order)
screenshots += user.screenshots(order: order, page: 2)

# Search Steam apps by name:
apps = Rsteamshot::App.search('witcher 3')
# => [#<Rsteamshot::App:0x007feb28b135f8 @id=292030, @name="The Witcher 3: Wild Hunt"...
apps.size
# => 18

# Find the best match for a Steam app by name:
app = Rsteamshot::App.find_by_name('oblivion')
# => #<Rsteamshot::App:0x007feb25dbd518 @id=22330, @name="The Elder Scrolls IV: Oblivion "...

# Filter a user's screenshots to those for a particular app:
alice_screenshots = user.screenshots(app_id: '19680')

# Find a Steam app by its ID:
app = Rsteamshot::App.find_by_id(377160)
# => #<Rsteamshot::App:0x007ff800438758 @id=377160, @name="Fallout 4"...

# Utility methods for an app:
app.to_h
# => {:id=>377160, :name=>"Fallout 4"}
app.to_json
# => "{\n  \"id\": 377160,\n  \"name\": \"Fallout 4\"\n}"

# Get screenshots uploaded for a Steam game:
app.per_page = 10
order = 'mostrecent' # also: toprated, trendday, trendweek, trendthreemonths, trendsixmonths,
                     # trendyear
screenshots = app.screenshots(order: order)
screenshots += app.screenshots(order: order, page: 2)

# Search an app's screenshots:
dog_screenshots = app.screenshots(query: 'dog', order: 'trendweek')

# Data available for each screenshot:
screenshots.each do |screenshot|
  screenshot.title
  # => "Lovely sunset in Toussaint"

  screenshot.details_url
  # => "http://steamcommunity.com/sharedfiles/filedetails/?id=737284878"

  screenshot.full_size_url
  # => "https://steamuserimages-a.akamaihd.net/ugc/1621679306978373648/FACBF0285AFB413467E0E76371E8796D8E8C263D/"

  screenshot.medium_url
  # => "https://steamuserimages-a.akamaihd.net/ugc/1621679306978373648/FACBF0285AFB413467E0E76371E8796D8E8C263D/?interpolation=lanczos-none&output-format=jpeg&output-quality=95&fit=inside|1024:576&composite-to%3D%2A%2C%2A%7C1024%3A576&background-color=black"

  screenshot.user_name
  # => "cheshire137"

  screenshot.user_url
  # => "http://steamcommunity.com/id/cheshire137"

  screenshot.date
  # => #<DateTime: 2016-08-03T20:54:00+00:00 ((2457604j,75240s,0n),+0s,2299161j)>

  screenshot.file_size
  # => "0.367 MB"

  screenshot.file_size_in_bytes
  # => 367000

  screenshot.width
  # => 1920

  screenshot.height
  # => 1080

  screenshot.like_count
  # => 0

  screenshot.comment_count
  # => 0

  # Utility methods:
  screenshot.to_h
  # => {:details_url=>"http://steamcommunity.com/sharedfiles/filedetails/?id=737284878", :title=>...

  screenshot.to_json
  # => "{\n  \"details_url\": \"http://steamcommunity.com/sharedfiles/filedetails/?id=737284878\",
end

# Force the Steam apps list to be re-downloaded:
Rsteamshot::App.reset_list
Rsteamshot::App.download_apps_list
```

## Development

After checking out [the repo](https://github.com/cheshire137/rsteamshot), run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

[Bug reports](https://github.com/cheshire137/rsteamshot/issues) and pull requests are welcome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
