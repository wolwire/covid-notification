require 'httparty'
require 'json'
require 'rubygems'
require 'telegram/bot'

# require File.expand_path('../app/telegrambot.rb', __FILE__)
# require File.expand_path('../app/covid.rb', __FILE__)
# require File.expand_path('../app/center.rb', __FILE__)
# require File.expand_path('../app/base.rb', __FILE__)
# require File.expand_path('../app/session.rb', __FILE__)

class Application
  def initialize
    $settings = YAML.load(File.open(File.expand_path('../config/my_initializers.yml', __FILE__)))
    initialize_telegram_bot
    initialize_app
  end

  def send_notification
    Covid.empty_slots
  end

  private

  def initialize_telegram_bot
    Telegram.bots_config = {
      default: $settings['TELEGRAM_TOKEN'],
      chat: {
        token: $settings['TELEGRAM_TOKEN'],
        username: 'covid_report_trial_bot'
      },
    }
  end

  def initialize_app
    Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each { |f| load(f) }
  end
end
