require 'spec_helper'

describe GoogledocMarkdown do
  it 'has a version number' do
    expect(GoogledocMarkdown::VERSION).not_to be nil
  end

  it 'creates the expected fixture output' do
    input  = File.read File.join(File.dirname(__dir__), '/spec/fixtures/simple/input.html')
    output = File.read File.join(File.dirname(__dir__), '/spec/fixtures/simple/output.md')
    converter = GoogledocMarkdown::Converter.new(html: input)
    expect(converter.convert).to eq(output)
  end
end
