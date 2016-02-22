require 'roadie'
require 'css_parser'
require 'nokogiri'
require 'kramdown'
require 'cgi'

class GoogledocMarkdown::Converter

  def initialize html: nil
    @html = html.to_s
  end

  def to_html
    inlined = inline_styles(@html)
    body = body_for(inlined)
    doc = Nokogiri::HTML.fragment(body)

    doc.css('*').each do |el|

      rules = css_rules(el['style'])
      el.delete('style')
      el.delete('class')

      if rules['font-weight'] == 'bold'
        leading, content, trailing = partition_whitespace(el.inner_html)
        el.inner_html = "#{leading}<strong>#{content}</strong>#{trailing}"
      end

      if rules['font-style'] == 'italic'
        leading, content, trailing = partition_whitespace(el.inner_html)
        el.inner_html = "#{leading}<em>#{content}</em>#{trailing}"
      end

    end

    doc.css('h1, h2, h3').each do |heading|
      heading.inner_html = heading.inner_text
    end

    doc.css('ol').each do |ol|
      ol.delete('start')
    end

    doc.css('span').each do |span|
      #span.swap(span.children)
      span.add_next_sibling(span.children.to_html)
      span.remove
    end

    # first, fix the url by extracting the 'q' query param
    doc.css('a').each do |a|
      a['href'] = parse_link(a['href'])
    end

    doc
      .to_html
      .gsub("<p></p>", '')
      .lstrip
  end

  def to_markdown
    options = {
      input: :html,
      remove_span_html_tags: true, # TODO: this may be a noop because it's on the wrong kramdown converter
      line_width: 90000, # TODO: prevent line wrapping in a nicer way than this
    }
    Kramdown::Document.new(to_html, options).to_kramdown
  end

  def partition_whitespace(input)
    re = /\A(\s{0,})(\S|\S.*\S)(\s{0,})\z/
    matches = re.match(input)
    leading, content, trailing = matches[1], matches[2], matches[3]
    return [leading, content, trailing]
  end

  private

    def css_rules style_string
      declarations = {}
      rule_set = CssParser::RuleSet.new(nil, style_string)
      rule_set.each_declaration do |property, value, _|
        declarations[property] = value
      end
      declarations
    end

    def inline_styles html
      Roadie::Document.new(html).transform
    end

    def body_for html
      Nokogiri::HTML(html).css('body').inner_html
    end

    def parse_link href
      uri = URI.parse(href) rescue nil
      return href if uri.nil?

      params = CGI.parse(uri.query)
      params['q'].first
    end

end
