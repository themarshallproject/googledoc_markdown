class GoogledocMarkdown::Helpers

  def self.id_from_url(url)
    re = /\/document\/d\/(.+?)(\/|$)/
    matches = url.match(re)
    return matches.nil? ? nil : matches[1]
  end

end
