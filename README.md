# Chat experiment

A simple chatroom experiment similar to campfire using pusher, mongo and backbone. It supports
basic commands and listeners to perform actions.

Development was abandoned, but its still kinda neat :)

Hosted: quickchat.herokuapp.com

## Chat Commands

Comments are lacking, but the code is in `config/initializers/commands.rb` and the `app/models/command_processor.rb` files.

rename yourself

    /rename [newname]

change topic

    /topic [newtopic]

detect images

    # paste any url that looks like an image and it will be embedded

detect pastes

    # paste any multi-line text and it will be wrapped in `pre` tags

detect oembed *pretty rough around the edges*

    paste any url from
      - youtube
      - flickr
      - viddler
      - blip.tv
      - hulu
      - vimeo
      - dailymotion
      - scribd
      - slideshare
      - photobucket

    to have it embedded in the chat