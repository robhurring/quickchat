class OEmbed
  Providers = [
    /youtube.com\/watch.+/,
    /flickr\.com\/photos/,
    /viddler\.com/,
    /blip\.tv\/.+/,
    /hulu\.com\/watch.*/,
    /vimeo\.com/,
    /dailymotion\.com\/.+/,
    /scribd\.com\/.+/,
    /slideshare\.net/,
    /photobucket\.com\/(?:albums|groups)/
  ]

  class << self
    def regex
      %r{(?:https?://)?((?:www\.)?#{Providers.join '|'})}
    end
  end
end