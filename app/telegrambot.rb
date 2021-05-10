class Telegrambot
  def self.send_message(message)
    # p Telegram.bots[:chat].get_updates
    Telegram.bots[:chat].send_message({ text: message, chat_id: $settings["CHAT_ID"], parse_mode: :markdown })
  end
end
