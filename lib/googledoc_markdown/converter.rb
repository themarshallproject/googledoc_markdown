require 'roadie'
require 'css_parser'
require 'nokogiri'
require 'kramdown'
require 'cgi'

class GoogledocMarkdown::Converter

  def initialize(html: nil)
    inlined = inline_styles(html)
    @body = body_for(inlined)
  end

  def to_html

    doc = Nokogiri::HTML.fragment(@body)
    doc.css('*').each do |el|

      rules = css_rules(el['style'])
      el.delete('style')
      el.delete('class')

      if rules['font-weight'] == 'bold'
        el.inner_html = "<strong>#{el.inner_html}</strong>"
      end

      if rules['font-style'] == 'italic'
        el.inner_html = "<em>#{el.inner_html}</em>"
      end
    end

    doc.css('span').each do |span|
      span.swap(span.children) # remove <span> wrapping everything
    end

    doc.css('a').each do |a|
      a['href'] = parse_link(a['href'])
    end

    doc.to_html.lstrip
  end

  def to_markdown
    options = {
      input: :html,
      remove_span_html_tags: true,
      line_width: 90000,
    }
    Kramdown::Document.new(to_html(), options).to_kramdown
  end


  private

    def css_rules style_string
      declarations = {}
      rule_set = CssParser::RuleSet.new(nil, style_string)
      rule_set.each_declaration do |property, value, is_imporant|
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

    def parse_link(href)
      uri = URI.parse(href)
      params = CGI.parse(uri.query)
      params['q'].first
    end

end
