require 'spec_helper'

describe GoogledocMarkdown do

  def load_fixture path
    File.read(File.join(File.dirname(__dir__), "/spec/fixtures/#{path}"))
  end

  def fixtures
    Dir.glob(File.join(File.dirname(__dir__), "/spec/fixtures/*")).map do |path|
      File.basename(path)
    end
  end

  it 'has a version number' do
    expect(GoogledocMarkdown::VERSION).not_to be nil
  end

  it 'has fixtures' do
    expect(fixtures.count).to be > 0
  end

  it 'fails gracefully if no input is given' do
    converter = GoogledocMarkdown::Converter.new
    expect(converter.to_html).to eq('')
  end

  it 'partitions whitespace in [leading, content, trailing]' do
    converter = GoogledocMarkdown::Converter.new
    expect(converter.partition_whitespace(' my string  ')).to eq([" ", "my string", "  "])
    expect(converter.partition_whitespace('a')).to eq(["", "a", ""])
    expect(converter.partition_whitespace('   a ')).to eq(["   ", "a", " "])
    expect(converter.partition_whitespace('only trailing  ')).to eq(["", "only trailing", "  "])
    expect(converter.partition_whitespace(' only leading')).to eq([" ", "only leading", ""])
  end

  it 'converts font-weight:bold; tags to <strong> / **' do
    html = "<style>.bold{font-weight:bold;}</style><body><span class='bold'>bold</span></body>"
    converter = GoogledocMarkdown::Converter.new(html: html)
    expect(converter.to_html).to eq("<strong>bold</strong>")
    expect(converter.to_markdown).to eq("**bold**")
  end

  it 'converts font-style:italic; tags to <em> / *' do
    html = "<style>.italic{font-style:italic;}</style><body><span class='italic'>italic</span></body>"
    converter = GoogledocMarkdown::Converter.new(html: html)
    expect(converter.to_html).to eq("<em>italic</em>")
    expect(converter.to_markdown).to eq("*italic*")
  end

  it "converts fixtures to html" do
    fixtures.each do |fixture|
      converter = GoogledocMarkdown::Converter.new(html: load_fixture("#{fixture}/input.html"))
      expect(converter.to_html).to eq(load_fixture("#{fixture}/output.html"))
    end
  end

  it "converts fixtures to markdown" do
    fixtures.each do |fixture|
      converter = GoogledocMarkdown::Converter.new(html: load_fixture("#{fixture}/input.html"))
      expect(converter.to_markdown).to eq(load_fixture("#{fixture}/output.md"))
    end
  end

end
