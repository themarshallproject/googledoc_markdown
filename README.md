# googledoc_markdown

[![Circle CI](https://circleci.com/gh/ivarvong/googledoc_markdown.svg?style=svg)](https://circleci.com/gh/ivarvong/googledoc_markdown)

[![Build Status](https://travis-ci.org/ivarvong/googledoc_markdown.svg?branch=master)](https://travis-ci.org/ivarvong/googledoc_markdown)

[![Dependency Status](https://gemnasium.com/ivarvong/googledoc_markdown.svg)](https://gemnasium.com/ivarvong/googledoc_markdown)

## Why?

At [The Marshall Project](https://www.themarshallproject.org/), stories are edited in Google Docs. I wrote a quick tool to convert the HTML export from a Google Doc to Markdown. (Internally, our stories are stored as Markdown). Turns out, parsing CSS with regexes is not a great idea. This gem is the next iteration.

Here's the strategy:

1. Inline the CSS for `font-weight: bold;` and `font-style: italic;` based on the `.c01` (etc) classes with the `roadie` gem.
2. Parse the inline styles into a hash of CSS properties with the `css_parser` gem.
3. Wrap the `<span>` with either a `<strong>` or `<em>` based on the CSS properties on it. A single `<span>` may get wrapped multiple times if the text is both bold and italic, for example. Then remove all the `<span>`s.
4. Pass this cleaned HTML to `kramdown` to yield markdown.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'googledoc_markdown', github: 'ivarvong/googledoc_markdown', tag: 'v0.1.0'
```

And then execute:

    $ bundle

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ivarvong/googledoc_markdown.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
