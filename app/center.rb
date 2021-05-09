require File.expand_path('../base.rb', __FILE__)
class Center < Base
  NEXT_LINE = "\u0085".encode('utf-8')
  attr_accessor :center_id, :name, :address, :state_name, :district_name, :block_name, :pincode, :from, :to, :sessions

  def initialize(params)
    from_attributes(params)
    self.sessions = []
    params[:sessions].each do |session|
      sessions << Session.new(session)
    end
  end

  def available_sessions
    available_sessions = ''
    sessions.each do |session|
      if session.available?
        # puts name, session.available_date, session.available_capacity
        available_sessions += [name, address, session.available_date, session.available_capacity].join(NEXT_LINE)
      end
    end
    return if available_sessions == ''

    available_sessions
  end
end
