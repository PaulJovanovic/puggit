require './config/boot'
require './config/environment'
require 'clockwork'

module Clockwork
  every(2.hours, "Twitch Crawl", at: "*:00") do
    Twitch.crawl
  end
end
