Telegram.bots_config = {
  default: DEFAULT_BOT_TOKEN,
  chat: {
    token: CHAT_BOT_TOKEN,
    username: 'ChatBot', # to support commands with mentions (/help@ChatBot)
    server: 'http://local.bot.api.server', # for Local Bot API Server
  },
}

Telegram.bot.get_updates
Telegram.bot == Telegram.bots[:default] # true
Telegram.bots[:chat].send_message(...)
