require 'httparty'
require 'json'
require 'rubygems'
require 'telegram/bot'

class Application
  def initialize
    $settings = YAML.load(File.open(File.expand_path('../config/my_initializers.local.yml', __FILE__)))
    initialize_telegram_bot
    initialize_app
  end

  def send_notification
    $settings['REPEAT_TIMES'].times do
      Covid.empty_slots
      sleep 15
    end
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
