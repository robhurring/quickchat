class OEmbed
  Providers = {
    'www.youtube.com' => 'http://www.youtube.com/oembed?url=%s&format=json',
    'www.flickr.com' => 'http://www.flickr.com/services/oembed/?url=%s'
  }

  class << self
    def regex
      hosts = Providers.keys.join '|'
      %r{^https?:\/\/(#{Regexp.escape hosts})}
    end

    def url(url)
      url
    end
  end
end