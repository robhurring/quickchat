class OEmbed
  Providers = [
    'www.youtube.com',
    'www.flickr.com',
    'vimeo.com'
  ]

  class << self
    def regex
      hosts = Providers.map{ |host| Regexp.escape host }.join '|'
      %r{(?:https?://)(#{hosts})(?:\/(?:\S+))}
    end
  end
end