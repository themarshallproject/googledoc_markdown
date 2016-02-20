require 'spec_helper'

describe GoogledocMarkdown do

  def load_fixture path
    File.read File.join(File.dirname(__dir__), "/spec/fixtures/#{path}")
  end

  it 'has a version number' do
    expect(GoogledocMarkdown::VERSION).not_to be nil
  end

  it 'converts to html' do
    converter = GoogledocMarkdown::Converter.new(html: load_fixture('simple/input.html'))
    expect(converter.to_html).to eq(load_fixture('simple/output.html'))
  end

  it 'converts to markdown' do
    converter = GoogledocMarkdown::Converter.new(html: load_fixture('simple/input.html'))
    expect(converter.to_markdown).to eq(load_fixture('simple/output.md'))
  end

end
