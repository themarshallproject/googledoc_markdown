require 'spec_helper'

describe GoogledocMarkdown::Helpers do

  it "can extract a doc id from a url" do
    id = "1ASI7Bfmbp5XHxeNnZeHQlqDeQ"
    url_v1 = "https://docs.google.com/document/d/#{id}/edit"
    url_v2 = "https://docs.google.com/document/d/#{id}"
    expect(GoogledocMarkdown::Helpers.id_from_url(url_v1)).to eq(id)
    expect(GoogledocMarkdown::Helpers.id_from_url(url_v2)).to eq(id)
  end

  it "returns nil for a non-google-drive url" do
    expect(GoogledocMarkdown::Helpers.id_from_url("https://nytimes.com")).to eq(nil)
  end

end
