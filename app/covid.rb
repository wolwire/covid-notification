require File.expand_path('../base.rb', __FILE__)
class Covid
  PINCODES = [110044, 110019, 110062, 226016].freeze

  def self.empty_slots
    empty_slots = []
    PINCODES.each do |pincode|
      slots(Time.now.strftime('%d-%m-&%Y'), pincode).each do |slot|
        sessions_available = Center.new(slot).available_sessions
        empty_slots << sessions_available if sessions_available
      end
    end
    telegram_message = empty_slots == [] ? 'No empty slots' : empty_slots.join('\n')
    Telegrambot.send_message(telegram_message)
  end

  def self.slots(date, pincode)
    headers = {}
    headers['user-agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36'
    response = HTTParty.get("https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?pincode=#{pincode}&date=#{date}", headers: headers)
    JSON.parse(response.body, symbolize_names: true)[:centers]
  end
end
