require File.expand_path('../base.rb', __FILE__)
class Center < Base
  attr_accessor :center_id, :name, :address, :state_name, :district_name, :block_name, :pincode, :from, :to, :sessions
  def initialize(params)
    self.from_attributes(params)
    self.sessions = []
    params[:sessions].each do |session|
      self.sessions << Session.new(session)
    end
  end

  def available_sessions
    available_sessions = []
    self.sessions.each do |session|
      if session.available?
        puts self.name, session.available_date, session.available_capacity
        available_sessions << [self.name, session.available_date, session.available_capacity]
      end
    end
    return if available_sessions == []
    available_sessions
  end
end
