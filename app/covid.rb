require File.expand_path('../base.rb', __FILE__)
class Covid
  NEXT_LINE = "\u0085".encode('utf-8')
  def self.empty_slots
    empty_slots = ''
    districts.each do |district|
      empty_slots += "District: #{district[:district_name]} #{NEXT_LINE}Slots: #{NEXT_LINE}"
      empty_slots_in_district = []
      slots((DateTime.now).strftime('%d-%m-&%Y'), district[:district_id]).each do |slot|
        sessions_available = Center.new(slot).available_sessions
        empty_slots_in_district << sessions_available if sessions_available
      end
      empty_slots += empty_slots_in_district == [] ? "No slots available" : empty_slots_in_district.join(NEXT_LINE)
      empty_slots += NEXT_LINE
    end
    Telegrambot.send_message(empty_slots)
  end

  def self.slots(date, district_id)
    headers = {}
    headers['authorization'] = $settings["BEARER_TOKEN"]
    headers['user-agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36'
    response = HTTParty.get("https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=#{district_id}&date=#{date}", headers: headers)
    JSON.parse(response.body, symbolize_names: true)[:centers]
  end

  def self.districts
    headers = {}
    headers['user-agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36'
    response = HTTParty.get('https://cdn-api.co-vin.in/api/v2/admin/location/districts/9', headers: headers)
    JSON.parse(response.body, symbolize_names: true)[:districts]
  end
end
