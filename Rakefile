require "httparty"
require 'json'
require 'rubygems'
require 'telegram/bot'

require File.expand_path('../app/covid.rb', __FILE__)
require File.expand_path('../app/center.rb', __FILE__)
require File.expand_path('../app/base.rb', __FILE__)
require File.expand_path('../app/session.rb', __FILE__)
require File.expand_path('../app/twilio.rb', __FILE__)

namespace :covid do
  task :ping_empty_slots do
    Covid.empty_slots
  end
end
