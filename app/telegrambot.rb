class Telegrambot
  def self.send_message(message)
    Telegram.bots[:chat].send_message({ text: message, chat_id: $settings["CHAT_ID"] })
  end
end
