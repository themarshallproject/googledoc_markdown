# googledoc_markdown

Circle CI Status: [![Circle CI](https://circleci.com/gh/ivarvong/googledoc_markdown.svg?style=svg)](https://circleci.com/gh/ivarvong/googledoc_markdown)

Travis CI Status: [![Build Status](https://travis-ci.org/ivarvong/googledoc_markdown.svg?branch=master)](https://travis-ci.org/ivarvong/googledoc_markdown)

## Why?

At The Marshall Project, stories are edited in Google Docs. Many months ago I wrote a simple tool to convert the HTML export from a Google Doc to Markdown. (Internally, our stories are stored as Markdown).

Turns out, parsing CSS with regexes is not a great idea.

This gem is gluing four other gems together. Here's the strategy:

1. Inline the CSS for `font-weight: bold;` and `font-style: italic;` based on the `.c01` (etc) classes with the `roadie` gem.
2. Parse the inline styles into a hash of CSS properties with the `css_parser` gem.
3. Wrap the `<span>` with either a `<strong>` or `<em>` based on the CSS properties on it. A single `<span>` may get wrapped multiple times if the text is both bold and italic, for example. Then remove all the `<span>`s.
4. Pass this cleaned HTML to `kramdown` to yield markdown.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'googledoc_markdown'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install googledoc_markdown

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ivarvong/googledoc_markdown.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

